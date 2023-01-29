import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather_app/domain/weather/models/conditions.dart';

part 'day_conditions.freezed.dart';

@freezed
class DayConditions with _$DayConditions {
  const factory DayConditions({
    required Conditions overallDayConditions,
    required List<Conditions> hourConditions,
  }) = _DayConditions;

  const DayConditions._();

  DateTime get date => overallDayConditions.date;
}
