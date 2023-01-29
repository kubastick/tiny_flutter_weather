import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather_app/domain/weather/models/conditions.dart';
import 'package:weather_app/domain/weather/models/day_conditions.dart';

part 'weather.freezed.dart';

@freezed
class Weather with _$Weather {
  const factory Weather({
    required Conditions currentConditions,
    required List<DayConditions> days,
  }) = _Weather;
}
