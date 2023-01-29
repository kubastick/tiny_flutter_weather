import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';

part 'weather_data_source.chopper.dart';

@injectable
@ChopperApi(baseUrl: "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/")
abstract class WeatherDataSource extends ChopperService {
  @factoryMethod
  static WeatherDataSource create([ChopperClient? client]) => _$WeatherDataSource(client);

  @Get(path: "{latitude},{longitude}?unitGroup={unitGroup}&include=days%2Chours%2Ccurrent&key={key}&contentType=json")
  Future<Response<Map<String, dynamic>>> getWeather({
    @Path() required double latitude,
    @Path() required double longitude,
    @Path() required String key,
    @Path() String unitGroup = "metric",
  });
}
