import 'package:injectable/injectable.dart';
import 'package:weather_app/data/common/bidirectional_data_mapper.dart';
import 'package:weather_app/data/weather/dtos/day_conditions_dto.dart';
import 'package:weather_app/data/weather/mappers/conditions_dto_mapper.dart';
import 'package:weather_app/domain/weather/models/day_conditions.dart';

@injectable
class DayConditionsDTOMapper implements BiDirectionalDataMapper<DayConditions, DayConditionsDTO> {
  DayConditionsDTOMapper(
    this._conditionsDTOMapper,
  );

  final ConditionsDTOMapper _conditionsDTOMapper;

  @override
  DayConditions from(DayConditionsDTO data) {
    return DayConditions(
      overallDayConditions: _conditionsDTOMapper.from(data),
      hourConditions: data.hours.map(_conditionsDTOMapper.from).toList(),
    );
  }

  @override
  DayConditionsDTO to(DayConditions data) {
    final conditionsDto = _conditionsDTOMapper.to(data.overallDayConditions);

    return DayConditionsDTO(
      datetimeEpoch: conditionsDto.datetimeEpoch,
      temp: conditionsDto.temp,
      hours: data.hourConditions.map(_conditionsDTOMapper.to).toList(),
      icon: conditionsDto.icon,
    );
  }
}
