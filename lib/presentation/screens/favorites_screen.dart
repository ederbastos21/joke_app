import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/joke_providers.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesAsync = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos')),
      body: favoritesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) =>
            const Center(child: Text('Erro ao carregar favoritos.')),
        data: (favorites) {
          if (favorites.isEmpty) {
            return const Center(child: Text('Nenhuma piada favorita ainda.'));
          }

          return ListView.separated(
            itemCount: favorites.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final joke = favorites[index];

              return ListTile(
                title: Text(
                  joke.fullText,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(joke.category),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () {
                    ref
                        .read(favoritesProvider.notifier)
                        .removeFavorite(joke.id);
                  },
                ),
                onTap: () => context.push('/detail/${joke.id}'),
              );
            },
          );
        },
      ),
    );
  }
}
