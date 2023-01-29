import 'package:injectable/injectable.dart';
import 'package:weather_app/data/common/bidirectional_data_mapper.dart';
import 'package:weather_app/data/weather/dtos/icon_type_dto.dart';
import 'package:weather_app/domain/weather/models/icon_type.dart';

@injectable
class IconTypeDTOMapper implements BiDirectionalDataMapper<IconType, IconTypeDTO> {
  @override
  IconType from(IconTypeDTO data) {
    switch (data) {
      case IconTypeDTO.snow:
        return IconType.rain;
      case IconTypeDTO.rain:
        return IconType.rain;
      case IconTypeDTO.fog:
        return IconType.cloud;
      case IconTypeDTO.wind:
        return IconType.cloud;
      case IconTypeDTO.cloudy:
        return IconType.cloud;
      case IconTypeDTO.partlyCloudyDay:
        return IconType.sun;
      case IconTypeDTO.partlyCloudyNight:
        return IconType.sun;
      case IconTypeDTO.clearDay:
        return IconType.sun;
      case IconTypeDTO.clearNight:
        return IconType.sun;
    }
  }

  @override
  IconTypeDTO to(IconType data) {
    switch (data) {
      case IconType.cloud:
        return IconTypeDTO.cloudy;
      case IconType.rain:
        return IconTypeDTO.rain;
      case IconType.sun:
        return IconTypeDTO.clearDay;
    }
  }
}
