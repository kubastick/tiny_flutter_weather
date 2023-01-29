import 'package:freezed_annotation/freezed_annotation.dart';

part 'city_dto.g.dart';

@JsonSerializable()
class CityDto {
  const CityDto({
    required this.name,
    required this.longitude,
    required this.latitude,
  });

  final String name;
  final double longitude;
  final double latitude;

  factory CityDto.fromJson(Map<String, dynamic> json) => _$CityDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CityDtoToJson(this);
}
