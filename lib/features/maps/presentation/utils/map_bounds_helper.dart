import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../stops/domain/entities/stop.dart';

class MapBoundsHelper {
  MapBoundsHelper._();

  static LatLngBounds? fromStops(List<TripStop> stops) {
    final points = stops
        .where((stop) => stop.latitude != null && stop.longitude != null)
        .map((stop) => LatLng(stop.latitude!, stop.longitude!))
        .toList();

    if (points.isEmpty) return null;

    return LatLngBounds.fromPoints(points);
  }
}