import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:jokes_app/main.dart' as app;

// Teste de integração: valida o fluxo completo do app.
// Abre o app → aguarda a piada carregar → vai para Configurações →
// alterna o tema → volta para Home.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Fluxo completo: home → configurações → alternar tema → voltar',
      (tester) async {
    // Inicia o app real
    app.main();
    await tester.pumpAndSettle();

    // Aguarda a piada carregar (pode demorar por conta da API)
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // Verifica que a HomeScreen está visível
    expect(find.text('Piada do Dia'), findsOneWidget);

    // Toca no botão de Configurações
    await tester.tap(find.byTooltip('Configurações'));
    await tester.pumpAndSettle();

    // Verifica que a tela de configurações abriu
    expect(find.text('Configurações'), findsOneWidget);
    expect(find.text('Modo escuro'), findsOneWidget);

    // Alterna o switch de tema
    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    // Volta para a Home
    final backButton = find.byTooltip('Back');
    if (backButton.evaluate().isNotEmpty) {
      await tester.tap(backButton);
    } else {
      // Em Android pode ser um botão diferente
      await tester.pageBack();
    }
    await tester.pumpAndSettle();

    // Verifica que voltou para a Home
    expect(find.text('Piada do Dia'), findsOneWidget);
  });
}
