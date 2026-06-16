// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'joke_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JokeModel _$JokeModelFromJson(Map<String, dynamic> json) => JokeModel(
      id: (json['id'] as num).toInt(),
      category: json['category'] as String,
      type: json['type'] as String,
      setup: json['setup'] as String?,
      delivery: json['delivery'] as String?,
      joke: json['joke'] as String?,
      safe: json['safe'] as bool,
    );

Map<String, dynamic> _$JokeModelToJson(JokeModel instance) => <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'type': instance.type,
      'setup': instance.setup,
      'delivery': instance.delivery,
      'joke': instance.joke,
      'safe': instance.safe,
    };
