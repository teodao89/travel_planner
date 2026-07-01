import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../documents/presentation/providers/document_provider.dart';
import '../../../stops/presentation/providers/trip_stop_provider.dart';
import 'trip_provider.dart';

class HomeDashboardData {
  final int tripCount;
  final int stopCount;
  final int documentCount;
  final double totalBudget;

  const HomeDashboardData({
    required this.tripCount,
    required this.stopCount,
    required this.documentCount,
    required this.totalBudget,
  });
}

final homeDashboardProvider = Provider<HomeDashboardData>((ref) {
  final trips = ref.watch(tripListProvider);

  final stopCount = trips.fold<int>(
    0,
        (sum, trip) => sum + ref.watch(tripStopsProvider(trip.id)).length,
  );

  final documentCount = trips.fold<int>(
    0,
        (sum, trip) => sum + ref.watch(documentsProvider(trip.id)).length,
  );

  final totalBudget = trips.fold<double>(
    0,
        (sum, trip) => sum + trip.budget,
  );

  return HomeDashboardData(
    tripCount: trips.length,
    stopCount: stopCount,
    documentCount: documentCount,
    totalBudget: totalBudget,
  );
});
