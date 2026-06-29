import 'package:flutter/material.dart';

import '../../../../core/services/app_snackbar_service.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_section.dart';
import '../../../maps/presentation/pages/trip_map_page.dart';
import '../../../stops/presentation/pages/trip_timeline_page.dart';
import '../../domain/entities/trip.dart';
import '../widgets/detail/trip_hero_header.dart';
import '../widgets/detail/trip_progress_card.dart';
import '../widgets/detail/trip_quick_actions.dart';
import '../widgets/detail/trip_section_grid.dart';

class TripDetailPage extends StatelessWidget {
  final Trip trip;

  const TripDetailPage({
    super.key,
    required this.trip,
  });

  void showComingSoon(BuildContext context, String feature) {
    AppSnackbarService.showInfo(
      context,
      '$feature disponibile nei prossimi step.',
    );
  }

  void openMap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TripMapPage(trip: trip),
      ),
    );
  }

  void openTimeline(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TripTimelinePage(trip: trip),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(trip.title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          TripHeroHeader(trip: trip),

          const SizedBox(height: AppSpacing.lg),

          const AppSection(
            title: 'Riepilogo',
            subtitle: 'Stato del viaggio',
          ),

          TripProgressCard(trip: trip),

          const SizedBox(height: AppSpacing.lg),

          const AppSection(
            title: 'Azioni rapide',
            subtitle: 'Aggiungi elementi al viaggio',
          ),

          TripQuickActions(
            onOpenMap: () => openMap(context),
            onAddStop: () => openTimeline(context),
            onAddExpense: () => showComingSoon(context, 'Budget'),
            onAddDocument: () => showComingSoon(context, 'Documenti'),
          ),

          const SizedBox(height: AppSpacing.lg),

          const AppSection(
            title: 'Organizza',
            subtitle: 'Tutte le sezioni del viaggio',
          ),

          TripSectionGrid(
            onTimelineTap: () => openTimeline(context),
          ),

          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }
}