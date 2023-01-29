import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/location/location_repository.dart';
import 'package:weather_app/domain/location/models/place.dart';

@injectable
class SaveSelectedPlaceUseCase {
  SaveSelectedPlaceUseCase(this._locationRepository);

  final LocationRepository _locationRepository;

  Future<void> call(Place place) => _locationRepository.saveSelectedPlace(place: place);
}
