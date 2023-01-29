// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:chopper/chopper.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i9;
import 'package:weather_app/core/di/config_module.dart' as _i28;
import 'package:weather_app/core/di/network_module.dart' as _i26;
import 'package:weather_app/core/di/storage_module.dart' as _i27;
import 'package:weather_app/core/env/app_config.dart' as _i3;
import 'package:weather_app/data/location/data_sources/google_places_data_source.dart' as _i6;
import 'package:weather_app/data/location/data_sources/selected_city_storage_data_source.dart' as _i13;
import 'package:weather_app/data/location/location_repository_impl.dart' as _i19;
import 'package:weather_app/data/location/mappers/city_dto_mapper.dart' as _i5;
import 'package:weather_app/data/location/mappers/place_dto_mapper.dart' as _i8;
import 'package:weather_app/data/weather/data_sources/weather_data_source.dart' as _i10;
import 'package:weather_app/data/weather/mappers/conditions_dto_mapper.dart' as _i11;
import 'package:weather_app/data/weather/mappers/day_conditions_dto_mapper.dart' as _i12;
import 'package:weather_app/data/weather/mappers/icon_type_dto_mapper.dart' as _i7;
import 'package:weather_app/data/weather/mappers/weather_dto_mapper.dart' as _i14;
import 'package:weather_app/data/weather/weather_repository_impl.dart' as _i16;
import 'package:weather_app/domain/location/location_repository.dart' as _i18;
import 'package:weather_app/domain/location/use_cases/get_selected_city_updated_stream.dart' as _i23;
import 'package:weather_app/domain/location/use_cases/get_selected_city_use_case.dart' as _i24;
import 'package:weather_app/domain/location/use_cases/save_selected_place_use_case.dart' as _i20;
import 'package:weather_app/domain/location/use_cases/search_for_places_use_case.dart' as _i21;
import 'package:weather_app/domain/weather/use_cases/get_weather_use_case.dart' as _i17;
import 'package:weather_app/domain/weather/weather_repository.dart' as _i15;
import 'package:weather_app/presentation/pages/home_page/home_page_cubit.dart' as _i25;
import 'package:weather_app/presentation/pages/select_city_page/select_city_page_cubit.dart' as _i22;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final configModule = _$ConfigModule();
    final networkModule = _$NetworkModule();
    final storageModule = _$StorageModule();
    gh.factory<_i3.AppConfig>(() => configModule.appConfig);
    gh.factory<_i4.ChopperClient>(() => networkModule.chopperClient);
    gh.factory<_i5.CityDtoMapper>(() => _i5.CityDtoMapper());
    gh.factory<_i6.GooglePlacesDataSource>(() => _i6.GooglePlacesDataSource.create(gh<_i4.ChopperClient>()));
    gh.factory<_i7.IconTypeDTOMapper>(() => _i7.IconTypeDTOMapper());
    gh.factory<_i8.PlaceDtoMapper>(() => _i8.PlaceDtoMapper());
    await gh.factoryAsync<_i9.SharedPreferences>(
      () => storageModule.sharedPreferences,
      preResolve: true,
    );
    gh.factory<_i10.WeatherDataSource>(() => _i10.WeatherDataSource.create(gh<_i4.ChopperClient>()));
    gh.factory<_i11.ConditionsDTOMapper>(() => _i11.ConditionsDTOMapper(gh<_i7.IconTypeDTOMapper>()));
    gh.factory<_i12.DayConditionsDTOMapper>(() => _i12.DayConditionsDTOMapper(gh<_i11.ConditionsDTOMapper>()));
    gh.factory<_i13.SelectedCityStorageDataSource>(
        () => _i13.SelectedCityStorageDataSource(gh<_i9.SharedPreferences>()));
    gh.factory<_i14.WeatherDTOMapper>(() => _i14.WeatherDTOMapper(
          gh<_i11.ConditionsDTOMapper>(),
          gh<_i12.DayConditionsDTOMapper>(),
        ));
    gh.lazySingleton<_i15.WeatherRepository>(() => _i16.WeatherRepositoryImpl(
          gh<_i3.AppConfig>(),
          gh<_i10.WeatherDataSource>(),
          gh<_i14.WeatherDTOMapper>(),
        ));
    gh.factory<_i17.GetWeatherUseCase>(() => _i17.GetWeatherUseCase(gh<_i15.WeatherRepository>()));
    gh.lazySingleton<_i18.LocationRepository>(() => _i19.LocationRepositoryImpl(
          gh<_i6.GooglePlacesDataSource>(),
          gh<_i8.PlaceDtoMapper>(),
          gh<_i13.SelectedCityStorageDataSource>(),
          gh<_i5.CityDtoMapper>(),
          gh<_i3.AppConfig>(),
        ));
    gh.factory<_i20.SaveSelectedPlaceUseCase>(() => _i20.SaveSelectedPlaceUseCase(gh<_i18.LocationRepository>()));
    gh.factory<_i21.SearchForPlacesUseCase>(() => _i21.SearchForPlacesUseCase(gh<_i18.LocationRepository>()));
    gh.factory<_i22.SelectCityPageCubit>(() => _i22.SelectCityPageCubit(
          gh<_i21.SearchForPlacesUseCase>(),
          gh<_i20.SaveSelectedPlaceUseCase>(),
        ));
    gh.factory<_i23.GetSelectedCityUpdatedStream>(
        () => _i23.GetSelectedCityUpdatedStream(gh<_i18.LocationRepository>()));
    gh.factory<_i24.GetSelectedCityUseCase>(() => _i24.GetSelectedCityUseCase(gh<_i18.LocationRepository>()));
    gh.factory<_i25.HomePageCubit>(() => _i25.HomePageCubit(
          gh<_i17.GetWeatherUseCase>(),
          gh<_i24.GetSelectedCityUseCase>(),
          gh<_i23.GetSelectedCityUpdatedStream>(),
        ));
    return this;
  }
}

class _$NetworkModule extends _i26.NetworkModule {}

class _$StorageModule extends _i27.StorageModule {}

class _$ConfigModule extends _i28.ConfigModule {}
