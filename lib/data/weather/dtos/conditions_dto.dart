import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/data/weather/dtos/icon_type_dto.dart';

part 'conditions_dto.g.dart';

@JsonSerializable()
class ConditionsDTO {
  const ConditionsDTO({
    required this.temp,
    required this.datetimeEpoch,
    required this.icon,
  });

  final double temp;
  final int datetimeEpoch;
  final IconTypeDTO icon;

  factory ConditionsDTO.fromJson(Map<String, dynamic> json) => _$ConditionsDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ConditionsDTOToJson(this);
}
