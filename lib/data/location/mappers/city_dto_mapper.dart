import 'package:injectable/injectable.dart';
import 'package:weather_app/data/common/bidirectional_data_mapper.dart';
import 'package:weather_app/data/location/dtos/city_dto.dart';
import 'package:weather_app/domain/location/models/city.dart';

@injectable
class CityDtoMapper implements BiDirectionalDataMapper<City, CityDto> {
  @override
  City from(CityDto data) {
    return City(
      name: data.name,
      latitude: data.latitude,
      longitude: data.longitude,
    );
  }

  @override
  CityDto to(City data) {
    return CityDto(
      name: data.name,
      longitude: data.longitude,
      latitude: data.latitude,
    );
  }
}
