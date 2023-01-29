import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather_app/domain/weather/models/icon_type.dart';

part 'conditions.freezed.dart';

@freezed
class Conditions with _$Conditions {
  const factory Conditions({
    required double temp,
    required DateTime date,
    required IconType icon,
  }) = _Conditions;
}
