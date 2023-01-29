import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:weather_app/core/env/app_config.dart';
import 'package:weather_app/data/location/data_sources/google_places_data_source.dart';
import 'package:weather_app/data/location/data_sources/selected_city_storage_data_source.dart';
import 'package:weather_app/data/location/dtos/location_autocomplete_response_dto.dart';
import 'package:weather_app/data/location/dtos/place_details_response_dto.dart';
import 'package:weather_app/data/location/mappers/city_dto_mapper.dart';
import 'package:weather_app/data/location/mappers/place_dto_mapper.dart';
import 'package:weather_app/domain/location/location_repository.dart';
import 'package:weather_app/domain/location/models/city.dart';
import 'package:weather_app/domain/location/models/place.dart';

const _defaultCity = City(
  name: "Warsaw",
  latitude: 52.14,
  longitude: 12.1,
);

@LazySingleton(as: LocationRepository)
class LocationRepositoryImpl implements LocationRepository {
  LocationRepositoryImpl(
    this._googlePlacesDataSource,
    this._placeDtoMapper,
    this._selectedCityStorageDataSource,
    this._cityDtoMapper,
    this._appConfig,
  );

  final AppConfig _appConfig;
  final GooglePlacesDataSource _googlePlacesDataSource;
  final SelectedCityStorageDataSource _selectedCityStorageDataSource;

  final PlaceDtoMapper _placeDtoMapper;
  final CityDtoMapper _cityDtoMapper;

  final _selectedCityUpdatedStreamController = StreamController<City>.broadcast();

  @override
  Future<List<Place>> searchPlaces({
    required String query,
    int resultsLimit = 15,
  }) async {
    final placesResponse = await _googlePlacesDataSource.getLocationAutocomplete(
      input: query,
      key: _appConfig.googlePlacesApiKey,
    );

    final placesJson = placesResponse.body;
    if (placesResponse.error == null && placesJson != null) {
      final responseDto = LocationAutocompleteResponseDto.fromJson(placesJson);

      return responseDto.predictions.map((p) => _placeDtoMapper.from(p)).toList();
    } else {
      throw Exception(placesResponse.error);
    }
  }

  @override
  Future<void> saveSelectedPlace({required Place place}) async {
    final placeDetailsResponse = await _googlePlacesDataSource.getPlaceDetails(
      placeId: place.id,
      key: _appConfig.googlePlacesApiKey,
    );

    final placeDetailsJson = placeDetailsResponse.body;
    if (placeDetailsResponse.error == null && placeDetailsJson != null) {
      final responseDto = PlaceDetailsResponseDto.fromJson(placeDetailsJson);
      final locationDto = responseDto.result.geometry.location;

      final city = City(
        name: place.name,
        latitude: locationDto.lat,
        longitude: locationDto.lng,
      );
      final cityDto = _cityDtoMapper.to(city);
      await _selectedCityStorageDataSource.saveSelectedCity(cityDto);
      _selectedCityUpdatedStreamController.add(city);

      return;
    } else {
      throw Exception(placeDetailsResponse.error);
    }
  }

  @override
  Stream<City> getSelectedCityUpdatedStream() => _selectedCityUpdatedStreamController.stream;

  @override
  City getSelectedCity() {
    final selectedCityDto = _selectedCityStorageDataSource.getSelectedCity();
    if (selectedCityDto != null) {
      return _cityDtoMapper.from(selectedCityDto);
    } else {
      return _defaultCity;
    }
  }

  Future<void> close() async {
    await _selectedCityUpdatedStreamController.close();
  }
}
