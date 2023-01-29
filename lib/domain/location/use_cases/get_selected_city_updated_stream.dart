import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/location/location_repository.dart';
import 'package:weather_app/domain/location/models/city.dart';

@injectable
class GetSelectedCityUpdatedStream {
  const GetSelectedCityUpdatedStream(this._locationRepository);

  final LocationRepository _locationRepository;

  Stream<City> call() => _locationRepository.getSelectedCityUpdatedStream();
}
