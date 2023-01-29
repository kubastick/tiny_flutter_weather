import 'package:injectable/injectable.dart';
import 'package:weather_app/data/common/bidirectional_data_mapper.dart';
import 'package:weather_app/data/weather/dtos/conditions_dto.dart';
import 'package:weather_app/data/weather/mappers/icon_type_dto_mapper.dart';
import 'package:weather_app/domain/weather/models/conditions.dart';

const _secondMillisecondEpochMapMultiplier = 1000;

@injectable
class ConditionsDTOMapper implements BiDirectionalDataMapper<Conditions, ConditionsDTO> {
  ConditionsDTOMapper(this._iconTypeDTOMapper);

  final IconTypeDTOMapper _iconTypeDTOMapper;

  @override
  Conditions from(ConditionsDTO data) {
    return Conditions(
      temp: data.temp,
      date: DateTime.fromMillisecondsSinceEpoch(data.datetimeEpoch * _secondMillisecondEpochMapMultiplier),
      icon: _iconTypeDTOMapper.from(data.icon),
    );
  }

  @override
  ConditionsDTO to(Conditions data) {
    return ConditionsDTO(
      temp: data.temp,
      datetimeEpoch: data.date.millisecondsSinceEpoch ~/ _secondMillisecondEpochMapMultiplier,
      icon: _iconTypeDTOMapper.to(data.icon),
    );
  }
}
