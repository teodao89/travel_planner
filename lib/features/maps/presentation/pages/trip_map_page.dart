import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/extensions/trip_stop_category_extensions.dart';
import '../../../../core/services/app_snackbar_service.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../stops/presentation/pages/new_stop_page.dart';
import '../../../stops/presentation/providers/trip_stop_provider.dart';
import '../../../trips/domain/entities/trip.dart';
import '../widgets/stop_details_bottom_sheet.dart';

class TripMapPage extends ConsumerWidget {
  final Trip trip;

  const TripMapPage({
    super.key,
    required this.trip,
  });

  void openStopDetails(BuildContext context, WidgetRef ref, dynamic stop) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (_) {
        return StopDetailsBottomSheet(
          stop: stop,
          onEdit: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => NewStopPage(
                  tripId: trip.id,
                  stop: stop,
                ),
              ),
            );
          },
          onDelete: () {
            Navigator.pop(context);
            ref.read(tripStopsProvider(trip.id).notifier).deleteStop(stop.id);
            AppSnackbarService.showSuccess(
              context,
              '${stop.title} eliminata',
            );
          },
          onNavigate: () async {
            Navigator.pop(context);

            if (stop.latitude == null || stop.longitude == null) {
              AppSnackbarService.showError(
                context,
                'Questa tappa non ha coordinate.',
              );
              return;
            }

            final launched = await NavigationService.openLocation(
              latitude: stop.latitude!,
              longitude: stop.longitude!,
              label: stop.title,
            );

            if (!launched && context.mounted) {
              AppSnackbarService.showError(
                context,
                'Impossibile aprire il navigatore.',
              );
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stops = ref.watch(tripStopsProvider(trip.id));

    final stopsWithCoordinates = stops
        .where((stop) => stop.latitude != null && stop.longitude != null)
        .toList();

    final routePoints = stopsWithCoordinates
        .map((stop) => LatLng(stop.latitude!, stop.longitude!))
        .toList();

    final center = stopsWithCoordinates.isEmpty
        ? const LatLng(41.9028, 12.4964)
        : LatLng(
      stopsWithCoordinates.first.latitude!,
      stopsWithCoordinates.first.longitude!,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('${trip.title} • Mappa'),
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: center,
          initialZoom: stopsWithCoordinates.isEmpty ? 5 : 13,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.teodao89.travel_planner',
          ),

          if (routePoints.length >= 2)
            PolylineLayer(
              polylines: [
                Polyline(
                  points: routePoints,
                  strokeWidth: 4,
                  color: Colors.indigo,
                ),
              ],
            ),

          MarkerLayer(
            markers: stopsWithCoordinates.map((stop) {
              final point = LatLng(stop.latitude!, stop.longitude!);

              return Marker(
                point: point,
                width: 64,
                height: 64,
                child: GestureDetector(
                  onTap: () => openStopDetails(context, ref, stop),
                  child: Icon(
                    stop.category.icon,
                    color: stop.category.color,
                    size: 42,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}