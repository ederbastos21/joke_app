import '../models/joke_model.dart';
import '../sources/joke_api_source.dart';
import '../sources/joke_local_source.dart';

class JokeRepository {
  final JokeApiSource _apiSource;
  final JokeLocalSource _localSource;

  JokeRepository(this._apiSource, this._localSource);

  Future<JokeModel> getRandomJoke() async {
    return _apiSource.fetchRandomJoke();
  }

  Future<List<JokeModel>> getFavorites() async {
    return _localSource.getFavorites();
  }

  Future<void> addFavorite(JokeModel joke) async {
    await _localSource.saveFavorite(joke);
  }

  Future<void> removeFavorite(int id) async {
    await _localSource.deleteFavorite(id);
  }

  Future<bool> isFavorite(int id) async {
    return _localSource.isFavorite(id);
  }
}
