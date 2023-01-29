import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather_app/data/location/dtos/location_dto.dart';

part 'geometry_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GeometryDto {
  const GeometryDto({
    required this.location,
  });

  final LocationDto location;

  factory GeometryDto.fromJson(Map<String, dynamic> json) => _$GeometryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GeometryDtoToJson(this);
}
