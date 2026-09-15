import 'package:json_annotation/json_annotation.dart';

part 'game_item.g.dart';

@JsonSerializable()
class GameItem {
  final String? id;
  final String? name;
  @JsonKey(name: 'background_image')
  final dynamic backgroundImage;
  final num? rating;

  GameItem({
    this.name,
    this.id,
    this.backgroundImage,
    this.rating
  });

  double? get ratingAsDouble => rating?.toDouble();

  factory GameItem.fromJson(Map<String, dynamic> json) => _$GameItemFromJson(json);
  Map<String, dynamic> toJson() => _$GameItemToJson(this);
}