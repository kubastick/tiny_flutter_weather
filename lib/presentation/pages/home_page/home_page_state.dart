part of 'home_page_cubit.dart';

@freezed
class HomePageState with _$HomePageState {
  const factory HomePageState.initial() = _HomePageStateInitial;

  const factory HomePageState.loading() = _HomePageStateLoading;

  const factory HomePageState.idle({
    required String currentCityName,
    required Conditions currentConditions,
    required List<Conditions> nextDaysConditions,
    required List<List<Conditions>> nextHourConditionRows,
  }) = _HomePageStateIdle;
}
