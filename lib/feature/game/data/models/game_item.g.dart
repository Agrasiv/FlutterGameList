// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameItem _$GameItemFromJson(Map<String, dynamic> json) => GameItem(
  name: json['name'] as String?,
  id: json['id'] as String?,
  backgroundImage: json['background_image'],
  rating: json['rating'] as num?,
);

Map<String, dynamic> _$GameItemToJson(GameItem instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'background_image': instance.backgroundImage,
  'rating': instance.rating,
};
