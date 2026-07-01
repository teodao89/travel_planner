import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_empty_state.dart';
import '../../../../shared/widgets/app_section.dart';
import '../../../../shared/widgets/home_header.dart';
import '../providers/home_dashboard_provider.dart';
import '../providers/trip_provider.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/trip_card.dart';
import '../widgets/trip_hero_card.dart';
import 'new_trip_page.dart';
import 'trip_detail_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  Future<void> openNewTripPage(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NewTripPage()),
    );
  }

  void openTripDetail(BuildContext context, dynamic trip) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TripDetailPage(trip: trip)),
    );
  }

  Future<void> confirmDeleteTrip(
      BuildContext context,
      WidgetRef ref,
      String tripId,
      String tripTitle,
      ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Eliminare viaggio?'),
          content: Text('Vuoi eliminare "$tripTitle"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Annulla'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Elimina'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      ref.read(tripListProvider.notifier).deleteTrip(tripId);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trips = ref.watch(tripListProvider);
    final dashboard = ref.watch(homeDashboardProvider);


    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            HomeHeader(tripCount: trips.length),
            const SizedBox(height: AppSpacing.lg),
            const AppSection(
              title: 'Dashboard',
              subtitle: 'La tua panoramica',
            ),
            DashboardCard(
              tripCount: dashboard.tripCount,
              stopCount: dashboard.stopCount,
              documentCount: dashboard.documentCount,
              budget: dashboard.totalBudget,
            ),
            const SizedBox(height: AppSpacing.lg),
            if (trips.isEmpty)
              AppEmptyState(
                icon: Icons.luggage,
                title: 'Nessun viaggio',
                message: 'Crea il tuo primo itinerario.',
                actionLabel: 'Nuovo viaggio',
                actionIcon: Icons.add,
                onAction: () => openNewTripPage(context),
              )
            else ...[
              const AppSection(
                title: 'Prossimo viaggio',
                subtitle: 'La tua prossima avventura',
              ),
              TripHeroCard(
                trip: trips.first,
                onOpen: () => openTripDetail(context, trips.first),
              ),
              const SizedBox(height: AppSpacing.lg),
              AppSection(
                title: 'I tuoi viaggi',
                subtitle:
                '${trips.length} viaggio${trips.length == 1 ? '' : 'i'}',
              ),
              const SizedBox(height: AppSpacing.sm),
              ...trips.map(
                    (trip) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: TripCard(
                    trip: trip,
                    onTap: () => openTripDetail(context, trip),
                    onDelete: () => confirmDeleteTrip(
                      context,
                      ref,
                      trip.id,
                      trip.title,
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => openNewTripPage(context),
        icon: const Icon(Icons.add),
        label: const Text('Nuovo viaggio'),
      ),
    );
  }
}