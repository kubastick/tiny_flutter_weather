import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather_app/data/location/dtos/place_dto.dart';

part 'location_autocomplete_response_dto.g.dart';

@JsonSerializable()
class LocationAutocompleteResponseDto {
  const LocationAutocompleteResponseDto({
    required this.predictions,
  });

  final List<PlaceDto> predictions;

  factory LocationAutocompleteResponseDto.fromJson(Map<String, dynamic> json) =>
      _$LocationAutocompleteResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LocationAutocompleteResponseDtoToJson(this);
}
