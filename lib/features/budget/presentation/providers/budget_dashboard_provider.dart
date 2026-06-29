import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../trips/domain/entities/trip.dart';
import 'budget_summary_provider.dart';

class BudgetDashboard {
  final double planned;
  final double spent;
  final double remaining;
  final double progress;

  final List<BudgetCategorySummary> categories;

  const BudgetDashboard({
    required this.planned,
    required this.spent,
    required this.remaining,
    required this.progress,
    required this.categories,
  });
}

final budgetDashboardProvider =
Provider.family<BudgetDashboard, Trip>((ref, trip) {
  final summary = ref.watch(
    budgetSummaryProvider(trip.id),
  );

  final planned = trip.budget;
  final spent = summary.total;

  final remaining =
  (planned - spent).clamp(0.0, double.infinity).toDouble();

  final progress = planned <= 0
      ? 0.0
      : (spent / planned).clamp(0.0, 1.0).toDouble();

  return BudgetDashboard(
    planned: planned,
    spent: spent,
    remaining: remaining,
    progress: progress,
    categories: summary.categories,
  );
});