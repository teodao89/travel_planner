import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/date_time_extensions.dart';
import '../../../../core/extensions/trip_stop_category_extensions.dart';
import '../../../../core/services/app_dialog_service.dart';
import '../../../../core/services/app_snackbar_service.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_empty_state.dart';
import '../../../../shared/widgets/app_timeline_tile.dart';
import '../../../trips/domain/entities/trip.dart';
import '../providers/trip_stop_provider.dart';
import 'new_stop_page.dart';

class TripTimelinePage extends ConsumerWidget {
  final Trip trip;

  const TripTimelinePage({
    super.key,
    required this.trip,
  });

  void openNewStopPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => NewStopPage(tripId: trip.id),
      ),
    );
  }

  void openEditStopPage(BuildContext context, dynamic stop) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => NewStopPage(
          tripId: trip.id,
          stop: stop,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stops = ref.watch(tripStopsProvider(trip.id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Timeline'),
      ),
      body: stops.isEmpty
          ? Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Center(
          child: AppEmptyState(
            icon: Icons.route_outlined,
            title: 'Nessuna tappa',
            message: 'Aggiungi la prima tappa del viaggio.',
            actionLabel: 'Aggiungi tappa',
            actionIcon: Icons.add_location_alt_outlined,
            onAction: () => openNewStopPage(context),
          ),
        ),
      )
          : ListView.separated(
        padding: const EdgeInsets.all(AppSpacing.lg),
        itemCount: stops.length,
        separatorBuilder: (_, _) =>
        const SizedBox(height: AppSpacing.md),
        itemBuilder: (context, index) {
          final stop = stops[index];

          return Dismissible(
            key: ValueKey(stop.id),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
              ),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
              child: const Icon(
                Icons.delete_outline,
                color: Colors.red,
              ),
            ),
            confirmDismiss: (_) async {
              return AppDialogService.confirm(
                context,
                title: 'Eliminare tappa?',
                message: 'Vuoi eliminare "${stop.title}"?',
                confirmText: 'Elimina',
                icon: Icons.delete_outline,
                color: Colors.red,
              );
            },
            onDismissed: (_) {
              ref
                  .read(tripStopsProvider(trip.id).notifier)
                  .deleteStop(stop.id);

              AppSnackbarService.showSuccess(
                context,
                '${stop.title} eliminata',
              );
            },
            child: AppTimelineTile(
              title: stop.title,
              subtitle:
              stop.address ?? stop.description ?? stop.category.label,
              time: stop.arrivalTime?.toItalianTime(),
              icon: stop.category.icon,
              color: stop.category.color,
              onTap: () => openEditStopPage(context, stop),
              trailing: const Icon(Icons.chevron_right),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => openNewStopPage(context),
        icon: const Icon(Icons.add),
        label: const Text('Tappa'),
      ),
    );
  }
}