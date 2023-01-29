import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LocationDto {
  const LocationDto({
    required this.lat,
    required this.lng,
  });

  final double lat;
  final double lng;

  factory LocationDto.fromJson(Map<String, dynamic> json) => _$LocationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LocationDtoToJson(this);
}
