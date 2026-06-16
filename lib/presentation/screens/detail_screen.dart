import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/joke_providers.dart';

class DetailScreen extends ConsumerWidget {
  final int jokeId;

  const DetailScreen({super.key, required this.jokeId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesAsync = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes')),
      body: favoritesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => const Center(child: Text('Erro ao carregar.')),
        data: (favorites) {
          final joke = favorites.where((j) => j.id == jokeId).firstOrNull;

          if (joke == null) {
            return const Center(
              child: Text('Piada não encontrada nos favoritos.'),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Categoria: ${joke.category}',
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Text('Tipo: ${joke.type}',
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 8),
                Text('Segura: ${joke.safe ? "Sim" : "Não"}',
                    style: Theme.of(context).textTheme.bodyMedium),
                const Divider(height: 32),
                Text(
                  joke.fullText,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
