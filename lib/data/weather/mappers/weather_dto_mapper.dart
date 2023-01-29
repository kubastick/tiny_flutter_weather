import 'package:injectable/injectable.dart';
import 'package:weather_app/data/common/bidirectional_data_mapper.dart';
import 'package:weather_app/data/weather/dtos/weather_dto.dart';
import 'package:weather_app/data/weather/mappers/conditions_dto_mapper.dart';
import 'package:weather_app/data/weather/mappers/day_conditions_dto_mapper.dart';
import 'package:weather_app/domain/weather/models/weather.dart';

@injectable
class WeatherDTOMapper implements BiDirectionalDataMapper<Weather, WeatherDTO> {
  WeatherDTOMapper(
    this._conditionsDTOMapper,
    this._dayConditionsDTOMapper,
  );

  final ConditionsDTOMapper _conditionsDTOMapper;
  final DayConditionsDTOMapper _dayConditionsDTOMapper;

  @override
  Weather from(WeatherDTO data) {
    return Weather(
      currentConditions: _conditionsDTOMapper.from(data.currentConditions),
      days: data.days.map(_dayConditionsDTOMapper.from).toList(),
    );
  }

  @override
  WeatherDTO to(Weather data) {
    return WeatherDTO(
      currentConditions: _conditionsDTOMapper.to(data.currentConditions),
      days: data.days.map(_dayConditionsDTOMapper.to).toList(),
    );
  }
}
