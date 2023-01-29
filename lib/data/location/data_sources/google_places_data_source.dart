import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';

part 'google_places_data_source.chopper.dart';

@injectable
@ChopperApi(baseUrl: "https://maps.googleapis.com/maps/api/place/")
abstract class GooglePlacesDataSource extends ChopperService {
  @factoryMethod
  static GooglePlacesDataSource create([ChopperClient? client]) => _$GooglePlacesDataSource(client);

  @Get(path: "autocomplete/json?input={input}&radius={radius}&types=(cities)&key={key}")
  Future<Response<Map<String, dynamic>>> getLocationAutocomplete({
    @Path() required String input,
    @Path() required String key,
    @Path() int radius = 50000,
  });

  @Get(path: "details/json?place_id={placeId}&fields=geometry&key={key}")
  Future<Response<Map<String, dynamic>>> getPlaceDetails({
    @Path() required String placeId,
    @Path() required String key,
  });
}
