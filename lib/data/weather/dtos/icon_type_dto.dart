import 'package:freezed_annotation/freezed_annotation.dart';

enum IconTypeDTO {
  snow,
  rain,
  fog,
  wind,
  cloudy,
  @JsonValue("partly-cloudy-day")
  partlyCloudyDay,
  @JsonValue("partly-cloudy-night")
  partlyCloudyNight,
  @JsonValue("clear-day")
  clearDay,
  @JsonValue("clear-night")
  clearNight,
}
