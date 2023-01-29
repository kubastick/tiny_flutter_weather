import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/data/location/dtos/city_dto.dart';

const _cityDtoKey = "selected_city";

@injectable
class SelectedCityStorageDataSource {
  SelectedCityStorageDataSource(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  CityDto? getSelectedCity() {
    final jsonString = _sharedPreferences.getString(_cityDtoKey);
    if (jsonString == null) {
      return null;
    }

    final json = jsonDecode(jsonString);
    return CityDto.fromJson(json);
  }

  Future<void> saveSelectedCity(CityDto city) async {
    final jsonString = jsonEncode(city.toJson());
    await _sharedPreferences.setString(_cityDtoKey, jsonString);
  }
}
