import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:jokes_app/data/models/joke_model.dart';
import 'package:jokes_app/presentation/widgets/joke_card.dart';
import 'package:jokes_app/presentation/screens/settings_screen.dart';
import 'package:jokes_app/providers/joke_providers.dart';

void main() {
  // ---------------------------------------------------------------------------
  // Teste 1: JokeCard exibe o texto da piada
  // ---------------------------------------------------------------------------
  testWidgets('JokeCard deve exibir o texto completo da piada', (tester) async {
    final joke = JokeModel(
      id: 1,
      category: 'Misc',
      type: 'twopart',
      setup: 'Qual é o oposto de volátil?',
      delivery: 'Voo de pedra.',
      safe: true,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: JokeCard(joke: joke)),
      ),
    );

    // Verifica se o setup e o delivery aparecem na tela
    expect(find.textContaining('Qual é o oposto de volátil?'), findsOneWidget);
    expect(find.textContaining('Voo de pedra.'), findsOneWidget);
  });

  // ---------------------------------------------------------------------------
  // Teste 2: JokeCard exibe piada single corretamente
  // ---------------------------------------------------------------------------
  testWidgets('JokeCard deve exibir piada single sem setup/delivery', (tester) async {
    final joke = JokeModel(
      id: 2,
      category: 'Programming',
      type: 'single',
      joke: 'Por que o programador usa óculos? Para melhorar o Java.',
      safe: true,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: JokeCard(joke: joke)),
      ),
    );

    expect(find.textContaining('Para melhorar o Java'), findsOneWidget);
  });

  // ---------------------------------------------------------------------------
  // Teste 3: SettingsScreen exibe o switch de tema
  // ---------------------------------------------------------------------------
  testWidgets('SettingsScreen deve exibir switch de modo escuro', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: SettingsScreen(),
        ),
      ),
    );

    // Verifica que o texto e o switch estão presentes
    expect(find.text('Modo escuro'), findsOneWidget);
    expect(find.byType(SwitchListTile), findsOneWidget);
  });
}
