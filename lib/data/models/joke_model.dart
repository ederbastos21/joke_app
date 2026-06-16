import 'package:json_annotation/json_annotation.dart';

part 'joke_model.g.dart';

@JsonSerializable()
class JokeModel {
  final int id;
  final String category;
  final String type;

  final String? setup;
  final String? delivery;

  final String? joke;

  final bool safe;

  JokeModel({
    required this.id,
    required this.category,
    required this.type,
    this.setup,
    this.delivery,
    this.joke,
    required this.safe,
  });

  factory JokeModel.fromJson(Map<String, dynamic> json) =>
      _$JokeModelFromJson(json);

  Map<String, dynamic> toJson() => _$JokeModelToJson(this);

  String get fullText {
    if (type == 'twopart') {
      return '$setup\n\n$delivery';
    }
    return joke ?? '';
  }
}
