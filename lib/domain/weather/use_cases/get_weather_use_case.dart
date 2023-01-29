import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/location/models/city.dart';
import 'package:weather_app/domain/weather/models/weather.dart';
import 'package:weather_app/domain/weather/weather_repository.dart';

@injectable
class GetWeatherUseCase {
  GetWeatherUseCase(this._weatherRepository);

  final WeatherRepository _weatherRepository;

  Future<Weather> call({
    required City city,
  }) =>
      _weatherRepository.getWeather(
        city: city,
      );
}
