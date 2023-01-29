import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather_app/data/weather/dtos/conditions_dto.dart';
import 'package:weather_app/data/weather/dtos/icon_type_dto.dart';

part 'day_conditions_dto.g.dart';

@JsonSerializable()
class DayConditionsDTO extends ConditionsDTO {
  const DayConditionsDTO({
    required super.datetimeEpoch,
    required super.temp,
    required super.icon,
    required this.hours,
  });

  @JsonKey(defaultValue: [])
  final List<ConditionsDTO> hours;

  factory DayConditionsDTO.fromJson(Map<String, dynamic> json) => _$DayConditionsDTOFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DayConditionsDTOToJson(this);
}
