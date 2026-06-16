import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'domain/app_router.dart';
import 'providers/joke_providers.dart';

void main() {
  runApp(
    const ProviderScope(
      child: JokesApp(),
    ),
  );
}

class JokesApp extends ConsumerWidget {
  const JokesApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'Piadas App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      routerConfig: appRouter,
    );
  }
}
