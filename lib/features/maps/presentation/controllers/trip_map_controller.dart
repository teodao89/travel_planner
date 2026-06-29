import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class TripMapController {
  final MapController controller = MapController();

  void moveTo(LatLng point, {double zoom = 14}) {
    controller.move(point, zoom);
  }

  void fitBounds(LatLngBounds bounds) {
    controller.fitCamera(
      CameraFit.bounds(
        bounds: bounds,
        padding: const EdgeInsets.all(48),
      ),
    );
  }
}