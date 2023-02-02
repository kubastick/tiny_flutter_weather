import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/domain/location/models/place.dart';
import 'package:weather_app/domain/location/use_cases/save_selected_place_use_case.dart';
import 'package:weather_app/domain/location/use_cases/search_for_places_use_case.dart';
import 'package:weather_app/presentation/pages/select_city_page/select_city_page_cubit.dart';

import 'select_city_page_cubit_test.mocks.dart';

@GenerateMocks([
  SearchForPlacesUseCase,
  SaveSelectedPlaceUseCase,
])
void main() {
  late SearchForPlacesUseCase searchForPlacesUseCase;
  late SaveSelectedPlaceUseCase saveSelectedPlaceUseCase;

  late SelectCityPageCubit cubit;

  const testSearchQuery = "Tes";
  const testPlace = Place(
    name: "Test",
    id: "",
  );

  const searchDebounceDuration = Duration(milliseconds: 900);

  setUp(() {
    searchForPlacesUseCase = MockSearchForPlacesUseCase();
    saveSelectedPlaceUseCase = MockSaveSelectedPlaceUseCase();

    cubit = SelectCityPageCubit(searchForPlacesUseCase, saveSelectedPlaceUseCase);
  });

  group("test cubit behaviour", () {
    blocTest<SelectCityPageCubit, SelectCityPageState>(
      "initialization works",
      build: () => cubit,
      act: (cubit) async => await cubit.initialize(),
      expect: () => [
        const SelectCityPageState.idle(
          places: [],
          showPlacesLoader: false,
        ),
      ],
    );

    blocTest<SelectCityPageCubit, SelectCityPageState>(
      "search works",
      setUp: () async {
        when(searchForPlacesUseCase(testSearchQuery)).thenAnswer((_) async => [testPlace]);
        await cubit.initialize();
      },
      build: () => cubit,
      act: (cubit) async => cubit.onCitySearchFieldUpdated(testSearchQuery),
      expect: () => [
        const SelectCityPageState.idle(
          places: [],
          showPlacesLoader: true,
        ),
        const SelectCityPageState.idle(
          places: [testPlace],
          showPlacesLoader: false,
        ),
      ],
      verify: (cubit) {
        verify(searchForPlacesUseCase(testSearchQuery)).called(1);
      },
      wait: searchDebounceDuration,
    );

    blocTest<SelectCityPageCubit, SelectCityPageState>(
      "saving city works",
      setUp: () async {
        when(searchForPlacesUseCase(testSearchQuery)).thenAnswer((_) async => [testPlace]);
        when(saveSelectedPlaceUseCase(testPlace)).thenAnswer((_) async {});

        await cubit.initialize();
        cubit.onCitySearchFieldUpdated(testSearchQuery);
        await Future.delayed(searchDebounceDuration);
      },
      build: () => cubit,
      act: (cubit) async => await cubit.onPlaceSelected(testPlace),
      expect: () => [
        const SelectCityPageState.loading(),
        const SelectCityPageState.done(),
      ],
      verify: (cubit) {
        verify(searchForPlacesUseCase(testSearchQuery)).called(1);
        verify(saveSelectedPlaceUseCase(testPlace)).called(1);
      },
    );
  });
}
