import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather_app/data/location/dtos/geometry_dto.dart';

part 'place_details_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PlaceDetailsDto {
  const PlaceDetailsDto({
    required this.geometry,
  });

  final GeometryDto geometry;

  factory PlaceDetailsDto.fromJson(Map<String, dynamic> json) => _$PlaceDetailsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceDetailsDtoToJson(this);
}
