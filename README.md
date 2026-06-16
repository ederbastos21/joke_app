# Jokes App

Aplicativo Flutter de piadas aleatórias usando a JokeAPI. Desenvolvido como projeto de consolidação dos conceitos de gestão de estado, navegação declarativa, consumo de API, persistência local e testes automatizados.

## Como rodar

Dentro da pasta do projeto:

```
flutter pub get
flutter run
```

Para os testes unitários e de widget:

```
flutter test test/unit test/widget
```

Para o teste de integração (requer emulador ou dispositivo conectado):

```
flutter test test/integration/app_flow_test.dart
```

## Estrutura

O projeto segue arquitetura limpa com camadas bem definidas. Em `data/sources` ficam as classes que acessam dados brutos: `JokeApiSource` consome a JokeAPI via Dio e `JokeLocalSource` gerencia o banco SQLite. Em `data/repositories` o `JokeRepository` une as duas fontes e é o único ponto de contato com os providers. Em `providers` ficam todos os StateNotifiers do Riverpod. Em `presentation` ficam as telas e widgets, sem nenhum acesso direto a dados.

## Requisitos atendidos

Riverpod gerencia todo o estado global via providers declarados em `joke_providers.dart`. GoRouter controla a navegação com a rota `/detail/:id` passando o ID da piada como parâmetro. Dio consome a API de forma assíncrona. SharedPreferences persiste a preferência de tema entre sessões. SQLite armazena as piadas favoritas. O modelo `JokeModel` usa `json_serializable` para geração de código. Os testes cobrem 5 casos unitários no modelo, 3 testes de widget e 1 teste de integração com fluxo completo.