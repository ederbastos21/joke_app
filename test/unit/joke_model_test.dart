import 'package:flutter_test/flutter_test.dart';
import 'package:jokes_app/data/models/joke_model.dart';

void main() {
  // ---------------------------------------------------------------------------
  // Teste 1: fromJson com piada de dois atos (twopart)
  // ---------------------------------------------------------------------------
  test('JokeModel.fromJson deve criar modelo correto para piada twopart', () {
    final json = {
      'id': 1,
      'category': 'Misc',
      'type': 'twopart',
      'setup': 'Por que o livro de matemática ficou triste?',
      'delivery': 'Porque tinha muitos problemas.',
      'joke': null,
      'safe': true,
    };

    final joke = JokeModel.fromJson(json);

    expect(joke.id, 1);
    expect(joke.category, 'Misc');
    expect(joke.type, 'twopart');
    expect(joke.setup, 'Por que o livro de matemática ficou triste?');
    expect(joke.delivery, 'Porque tinha muitos problemas.');
    expect(joke.safe, true);
  });

  // ---------------------------------------------------------------------------
  // Teste 2: fromJson com piada de ato único (single)
  // ---------------------------------------------------------------------------
  test('JokeModel.fromJson deve criar modelo correto para piada single', () {
    final json = {
      'id': 2,
      'category': 'Programming',
      'type': 'single',
      'setup': null,
      'delivery': null,
      'joke': 'Por que o programador usa óculos? Para melhorar o Java.',
      'safe': true,
    };

    final joke = JokeModel.fromJson(json);

    expect(joke.id, 2);
    expect(joke.type, 'single');
    expect(joke.joke, 'Por que o programador usa óculos? Para melhorar o Java.');
  });

  // ---------------------------------------------------------------------------
  // Teste 3: fullText para piada twopart retorna setup + delivery
  // ---------------------------------------------------------------------------
  test('fullText deve unir setup e delivery com quebra de linha para twopart', () {
    final joke = JokeModel(
      id: 3,
      category: 'Misc',
      type: 'twopart',
      setup: 'Pergunta',
      delivery: 'Resposta',
      safe: true,
    );

    expect(joke.fullText, 'Pergunta\n\nResposta');
  });

  // ---------------------------------------------------------------------------
  // Teste 4: fullText para piada single retorna apenas o campo joke
  // ---------------------------------------------------------------------------
  test('fullText deve retornar o campo joke para piada single', () {
    final joke = JokeModel(
      id: 4,
      category: 'Programming',
      type: 'single',
      joke: 'Piada de um ato.',
      safe: true,
    );

    expect(joke.fullText, 'Piada de um ato.');
  });

  // ---------------------------------------------------------------------------
  // Teste 5: toJson deve serializar de volta corretamente
  // ---------------------------------------------------------------------------
  test('toJson deve retornar mapa com todos os campos', () {
    final joke = JokeModel(
      id: 5,
      category: 'Dark',
      type: 'twopart',
      setup: 'Setup',
      delivery: 'Delivery',
      safe: false,
    );

    final json = joke.toJson();

    expect(json['id'], 5);
    expect(json['category'], 'Dark');
    expect(json['type'], 'twopart');
    expect(json['setup'], 'Setup');
    expect(json['delivery'], 'Delivery');
    expect(json['safe'], false);
  });
}
