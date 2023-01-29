import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/location/location_repository.dart';
import 'package:weather_app/domain/location/models/city.dart';

@injectable
class GetSelectedCityUseCase {
  GetSelectedCityUseCase(this._locationRepository);

  final LocationRepository _locationRepository;

  City call() => _locationRepository.getSelectedCity();
}
