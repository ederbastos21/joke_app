import 'package:dio/dio.dart';
import '../models/joke_model.dart';

class JokeApiSource {
  final Dio _dio;

  JokeApiSource(this._dio);

  Future<JokeModel> fetchRandomJoke() async {
    final response = await _dio.get(
      'https://v2.jokeapi.dev/joke/Any',
      queryParameters: {
        'safe-mode': true,
        '_t': DateTime.now().millisecondsSinceEpoch,
      },
      options: Options(
        headers: {
          'Cache-Control': 'no-cache',
          'Pragma': 'no-cache',
        },
      ),
    );

    return JokeModel.fromJson(response.data as Map<String, dynamic>);
  }
}
