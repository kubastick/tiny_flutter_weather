import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/data/weather/dtos/conditions_dto.dart';
import 'package:weather_app/data/weather/dtos/day_conditions_dto.dart';

part 'weather_dto.g.dart';

@JsonSerializable()
class WeatherDTO {
  WeatherDTO({
    required this.currentConditions,
    required this.days,
  });

  final ConditionsDTO currentConditions;
  @JsonKey(defaultValue: [])
  final List<DayConditionsDTO> days;

  factory WeatherDTO.fromJson(Map<String, dynamic> json) => _$WeatherDTOFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherDTOToJson(this);
}