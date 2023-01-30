import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/domain/location/location_repository.dart';
import 'package:weather_app/domain/location/models/city.dart';
import 'package:weather_app/domain/location/use_cases/get_selected_city_use_case.dart';

import 'get_selected_city_use_case_test.mocks.dart';

@GenerateMocks([
  LocationRepository,
])
void main() {
  late LocationRepository locationRepository;
  late GetSelectedCityUseCase getSelectedCityUseCase;

  setUp(() {
    locationRepository = MockLocationRepository();
    getSelectedCityUseCase = GetSelectedCityUseCase(locationRepository);
  });

  test("calls location repository and returns correct city", () {
    const expected = City(
      name: "Test City",
      latitude: 0.1,
      longitude: 19.9,
    );
    when(locationRepository.getSelectedCity()).thenAnswer((_) => expected);

    final result = getSelectedCityUseCase();

    expect(result, expected);
    verify(locationRepository.getSelectedCity()).called(1);
  });
}
