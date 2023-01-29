import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather_app/data/location/dtos/geometry_dto.dart';

part 'place_details_response_result_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PlaceDetailsResponseResultDto {
  const PlaceDetailsResponseResultDto({
    required this.geometry,
  });

  final GeometryDto geometry;

  factory PlaceDetailsResponseResultDto.fromJson(Map<String, dynamic> json) =>
      _$PlaceDetailsResponseResultDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceDetailsResponseResultDtoToJson(this);
}
