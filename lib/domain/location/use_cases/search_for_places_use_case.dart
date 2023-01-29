import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/location/location_repository.dart';
import 'package:weather_app/domain/location/models/place.dart';

@injectable
class SearchForPlacesUseCase {
  SearchForPlacesUseCase(this._locationRepository);

  final LocationRepository _locationRepository;

  Future<List<Place>> call(String query) => _locationRepository.searchPlaces(query: query);
}
