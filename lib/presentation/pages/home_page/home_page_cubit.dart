import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/location/models/city.dart';
import 'package:weather_app/domain/location/use_cases/get_selected_city_updated_stream.dart';
import 'package:weather_app/domain/location/use_cases/get_selected_city_use_case.dart';
import 'package:weather_app/domain/weather/models/conditions.dart';
import 'package:weather_app/domain/weather/use_cases/get_weather_use_case.dart';

part 'home_page_cubit.freezed.dart';

part 'home_page_state.dart';

@injectable
class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit(
    this._getWeatherUseCase,
    this._getSelectedCityUseCase,
    this._getSelectedCityUpdatedStream,
  ) : super(const HomePageState.initial());

  final GetWeatherUseCase _getWeatherUseCase;
  final GetSelectedCityUseCase _getSelectedCityUseCase;
  final GetSelectedCityUpdatedStream _getSelectedCityUpdatedStream;

  StreamSubscription<City>? _cityStreamSubscription;

  Future<void> initialize() async {
    emit(const HomePageState.loading());
    final city = _getSelectedCityUseCase();
    _listenForSelectedCityUpdates();
    await _loadCityWeather(city);
  }

  void _listenForSelectedCityUpdates() {
    _cityStreamSubscription = _getSelectedCityUpdatedStream().listen((updatedCity) {
      _loadCityWeather(updatedCity);
    });
  }

  Future<void> _loadCityWeather(City city) async {
    emit(const HomePageState.loading());
    final weather = await _getWeatherUseCase.call(city: city);

    final nextHoursConditions = weather.days
        .map((days) => days.hourConditions)
        .flattened
        .sortedBy((a) => a.date)
        .where((hourCondition) => hourCondition.date.isAfter(DateTime.now()))
        .take(10)
        .slices(5)
        .toList();

    emit(
      HomePageState.idle(
        currentCityName: city.name,
        currentConditions: weather.currentConditions,
        nextDaysConditions: weather.days.map((c) => c.overallDayConditions).toList(),
        nextHourConditionRows: nextHoursConditions,
      ),
    );
  }

  @override
  Future<void> close() async {
    await _cityStreamSubscription?.cancel();
    return super.close();
  }
}
