import 'package:weather_app/domain/location/models/city.dart';
import 'package:weather_app/domain/location/models/place.dart';

abstract class LocationRepository {
  Future<List<Place>> searchPlaces({
    required String query,
    int resultsLimit = 15,
  });

  Future<void> saveSelectedPlace({
    required Place place,
  });

  City getSelectedCity();

  Stream<City> getSelectedCityUpdatedStream();
}
