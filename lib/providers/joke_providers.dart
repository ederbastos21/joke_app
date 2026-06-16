import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/joke_model.dart';
import '../data/repositories/joke_repository.dart';
import '../data/sources/joke_api_source.dart';
import '../data/sources/joke_local_source.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

final jokeApiSourceProvider = Provider<JokeApiSource>((ref) {
  return JokeApiSource(ref.read(dioProvider));
});

final jokeLocalSourceProvider = Provider<JokeLocalSource>((ref) {
  return JokeLocalSource();
});

final jokeRepositoryProvider = Provider<JokeRepository>((ref) {
  return JokeRepository(
    ref.read(jokeApiSourceProvider),
    ref.read(jokeLocalSourceProvider),
  );
});

final themeModeProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier() : super(false) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool('dark_mode') ?? false;
  }

  Future<void> toggle() async {
    state = !state;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('dark_mode', state);
  }
}

final randomJokeProvider =
    StateNotifierProvider<RandomJokeNotifier, AsyncValue<JokeModel>>(
  (ref) => RandomJokeNotifier(ref.read(jokeRepositoryProvider)),
);

class RandomJokeNotifier extends StateNotifier<AsyncValue<JokeModel>> {
  final JokeRepository _repository;

  RandomJokeNotifier(this._repository) : super(const AsyncValue.loading()) {
    fetchNew();
  }

  Future<void> fetchNew() async {
    state = const AsyncValue.loading();
    try {
      final joke = await _repository.getRandomJoke();
      state = AsyncValue.data(joke);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, AsyncValue<List<JokeModel>>>(
  (ref) => FavoritesNotifier(ref.read(jokeRepositoryProvider)),
);

class FavoritesNotifier extends StateNotifier<AsyncValue<List<JokeModel>>> {
  final JokeRepository _repository;

  FavoritesNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    state = const AsyncValue.loading();
    try {
      final favorites = await _repository.getFavorites();
      state = AsyncValue.data(favorites);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addFavorite(JokeModel joke) async {
    await _repository.addFavorite(joke);
    await loadFavorites();
  }

  Future<void> removeFavorite(int id) async {
    await _repository.removeFavorite(id);
    await loadFavorites();
  }

  bool isFavorite(int id) {
    return state.valueOrNull?.any((j) => j.id == id) ?? false;
  }
}
