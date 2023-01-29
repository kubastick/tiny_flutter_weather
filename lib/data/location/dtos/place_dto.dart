import 'package:freezed_annotation/freezed_annotation.dart';

part 'place_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PlaceDto {
  const PlaceDto({
    required this.description,
    required this.placeId,
  });

  final String description;
  final String placeId;

  factory PlaceDto.fromJson(Map<String, dynamic> json) => _$PlaceDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceDtoToJson(this);
}
