import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather_app/data/location/dtos/place_details_response_result_dto.dart';

part 'place_details_response_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PlaceDetailsResponseDto {
  const PlaceDetailsResponseDto({
    required this.result,
  });

  final PlaceDetailsResponseResultDto result;

  factory PlaceDetailsResponseDto.fromJson(Map<String, dynamic> json) => _$PlaceDetailsResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceDetailsResponseDtoToJson(this);
}
