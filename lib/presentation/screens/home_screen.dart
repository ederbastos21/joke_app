import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/joke_providers.dart';
import '../widgets/joke_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jokeAsync = ref.watch(randomJokeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Piada do Dia'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            tooltip: 'Favoritos',
            onPressed: () => context.push('/favorites'),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Configurações',
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: jokeAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Erro ao carregar piada.'),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () =>
                    ref.read(randomJokeProvider.notifier).fetchNew(),
                child: const Text('Tentar novamente'),
              ),
            ],
          ),
        ),
        data: (joke) => Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              JokeCard(joke: joke),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.info_outline),
                    label: const Text('Detalhes'),
                    onPressed: () => context.push('/detail/${joke.id}'),
                  ),
                  Consumer(
                    builder: (context, ref, _) {
                      final isFav = ref
                              .watch(favoritesProvider)
                              .valueOrNull
                              ?.any((j) => j.id == joke.id) ??
                          false;

                      return ElevatedButton.icon(
                        icon: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border),
                        label: Text(isFav ? 'Remover' : 'Favoritar'),
                        onPressed: () {
                          final notifier = ref.read(favoritesProvider.notifier);
                          if (isFav) {
                            notifier.removeFavorite(joke.id);
                          } else {
                            notifier.addFavorite(joke);
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextButton.icon(
                icon: const Icon(Icons.refresh),
                label: const Text('Nova piada'),
                onPressed: () =>
                    ref.read(randomJokeProvider.notifier).fetchNew(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
