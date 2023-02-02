import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weather_app/domain/location/models/place.dart';
import 'package:weather_app/domain/location/use_cases/save_selected_place_use_case.dart';
import 'package:weather_app/domain/location/use_cases/search_for_places_use_case.dart';

part 'select_city_page_cubit.freezed.dart';
part 'select_city_page_state.dart';

// TODO: Export this to something like AppConst and inject it to allow more reliable cubit behaviour testing
const _searchDebounceDuration = Duration(milliseconds: 500);

@injectable
class SelectCityPageCubit extends Cubit<SelectCityPageState> {
  SelectCityPageCubit(
    this._searchForPlacesUseCase,
    this._saveSelectedPlaceUseCase,
  ) : super(const SelectCityPageState.loading());

  final SearchForPlacesUseCase _searchForPlacesUseCase;
  final SaveSelectedPlaceUseCase _saveSelectedPlaceUseCase;

  final _searchStreamController = StreamController<String>.broadcast();
  var _places = <Place>[];

  StreamSubscription<String>? _searchStreamSubscription;

  Future<void> initialize() async {
    _listenForDebouncedSearchUpdates();
    _emitIdle();
  }

  void _listenForDebouncedSearchUpdates() {
    _searchStreamSubscription = _searchStreamController.stream
        .debounce((_) => TimerStream(true, _searchDebounceDuration))
        .listen((event) async {
      _places = await _searchForPlacesUseCase(event);
      _emitIdle();
    });
  }

  void onCitySearchFieldUpdated(String value) {
    _emitIdle(showPlacesLoader: true);
    _searchStreamController.add(value);
  }

  Future<void> onPlaceSelected(Place place) async {
    emit(const SelectCityPageState.loading());
    await _saveSelectedPlaceUseCase(place);
    emit(const SelectCityPageState.done());
  }

  void _emitIdle({bool showPlacesLoader = false}) async {
    emit(
      SelectCityPageState.idle(
        places: _places,
        showPlacesLoader: showPlacesLoader,
      ),
    );
  }

  @override
  Future<void> close() async {
    await _searchStreamSubscription?.cancel();
    await _searchStreamController.close();
    return super.close();
  }
}
