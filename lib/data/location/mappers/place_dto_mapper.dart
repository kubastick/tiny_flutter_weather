import 'package:injectable/injectable.dart';
import 'package:weather_app/data/common/bidirectional_data_mapper.dart';
import 'package:weather_app/data/location/dtos/place_dto.dart';
import 'package:weather_app/domain/location/models/place.dart';

@injectable
class PlaceDtoMapper implements BiDirectionalDataMapper<Place, PlaceDto> {
  @override
  Place from(PlaceDto data) {
    return Place(
      name: data.description,
      id: data.placeId,
    );
  }

  @override
  PlaceDto to(Place data) {
    return PlaceDto(
      description: data.name,
      placeId: data.id,
    );
  }
}
