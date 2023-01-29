part of 'select_city_page_cubit.dart';

@freezed
class SelectCityPageState with _$SelectCityPageState {
  const factory SelectCityPageState.loading() = _SelectCityPageStateLoading;

  const factory SelectCityPageState.idle({
    required List<Place> places,
    required bool showPlacesLoader,
  }) = _SelectCityPageStateIdle;

  const factory SelectCityPageState.done() = _SelectCityPageStateDone;
}
