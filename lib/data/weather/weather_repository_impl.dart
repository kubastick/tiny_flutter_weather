import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:weather_app/core/env/app_config.dart';
import 'package:weather_app/data/weather/data_sources/weather_data_source.dart';
import 'package:weather_app/data/weather/dtos/weather_dto.dart';
import 'package:weather_app/data/weather/mappers/weather_dto_mapper.dart';
import 'package:weather_app/domain/location/models/city.dart';
import 'package:weather_app/domain/weather/models/weather.dart';
import 'package:weather_app/domain/weather/weather_repository.dart';

@LazySingleton(as: WeatherRepository)
class WeatherRepositoryImpl implements WeatherRepository {
  WeatherRepositoryImpl(
    this._appConfig,
    this._weatherDataSource,
    this._weatherDTOMapper,
  );

  final AppConfig _appConfig;

  final WeatherDataSource _weatherDataSource;
  final WeatherDTOMapper _weatherDTOMapper;

  @override
  Future<Weather> getWeather({required City city}) async {
    final weatherResponse = await _weatherDataSource.getWeather(
      latitude: city.latitude,
      longitude: city.longitude,
      key: _appConfig.visualCrossingApiKey,
    );
    final weatherJson = weatherResponse.body;
    if (weatherResponse.error == null && weatherJson != null) {
      final weatherDto = WeatherDTO.fromJson(weatherJson);
      return _weatherDTOMapper.from(weatherDto);
    } else {
      throw Exception(weatherResponse.error);
    }
  }
}
