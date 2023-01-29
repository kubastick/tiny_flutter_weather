import 'package:freezed_annotation/freezed_annotation.dart';

part 'place.freezed.dart';

@freezed
class Place with _$Place {
  const factory Place({
    required String name,
    required String id,
  }) = _Place;
}
