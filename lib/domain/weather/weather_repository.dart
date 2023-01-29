import 'package:weather_app/domain/location/models/city.dart';
import 'package:weather_app/domain/weather/models/weather.dart';

abstract class WeatherRepository {
  Future<Weather> getWeather({
    required City city,
  });
}
