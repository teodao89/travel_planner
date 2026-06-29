import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/expense_category_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_empty_state.dart';
import '../../../../shared/widgets/app_section.dart';
import '../../../trips/domain/entities/trip.dart';
import '../providers/expense_provider.dart';
import '../widgets/budget_category_card.dart';
import '../widgets/budget_summary_card.dart';
import 'new_expense_page.dart';
import '../widgets/expense_tile.dart';
import '../providers/budget_dashboard_provider.dart';

class BudgetPage extends ConsumerWidget {
  final Trip trip;

  const BudgetPage({
    super.key,
    required this.trip,
  });

  void openNewExpensePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => NewExpensePage(
          tripId: trip.id,
        ),
      ),
    );
  }

  void openEditExpensePage(BuildContext context, expense) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => NewExpensePage(
          tripId: trip.id,
          expense: expense,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenses = ref.watch(expensesProvider(trip.id));
    final dashboard = ref.watch(
      budgetDashboardProvider(trip),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('${trip.title} • Budget'),
      ),
      body: expenses.isEmpty
          ? Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Center(
          child: AppEmptyState(
            icon: Icons.account_balance_wallet_outlined,
            title: 'Nessuna spesa',
            message: 'Aggiungi la prima spesa del viaggio.',
            actionLabel: 'Nuova spesa',
            actionIcon: Icons.add,
            onAction: () => openNewExpensePage(context),
          ),
        ),
      )
          : ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          const AppSection(
            title: 'Riepilogo',
            subtitle: 'Panoramica delle spese',
          ),

          BudgetSummaryCard(
            icon: Icons.savings_outlined,
            label: 'Budget previsto',
            value: '€ ${dashboard.planned.toStringAsFixed(2)}',
            color: Colors.blue,
          ),

          const SizedBox(height: AppSpacing.md),

          BudgetSummaryCard(
            icon: Icons.account_balance_wallet_outlined,
            label: 'Totale speso',
            value: '€ ${dashboard.spent.toStringAsFixed(2)}',
            color: Colors.green,
          ),

          const SizedBox(height: AppSpacing.md),

          BudgetSummaryCard(
            icon: Icons.payments_outlined,
            label: 'Budget residuo',
            value: '€ ${dashboard.remaining.toStringAsFixed(2)}',
            color: dashboard.remaining > 0
                ? Colors.orange
                : Colors.red,
          ),

          const SizedBox(height: AppSpacing.lg),

          LinearProgressIndicator(
            value: dashboard.progress,
            minHeight: 10,
            borderRadius: BorderRadius.circular(12),
          ),

          const SizedBox(height: AppSpacing.sm),

          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${(dashboard.progress * 100).toStringAsFixed(0)}%',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          const AppSection(
            title: 'Categorie',
            subtitle: 'Spese raggruppate',
          ),

          const SizedBox(height: AppSpacing.sm),

          ...dashboard.categories.map(
                (item) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: BudgetCategoryCard(
                icon: item.category.icon,
                color: item.category.color,
                category: item.category.label,
                amount: item.total,
                expensesCount: item.count,
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          const AppSection(
            title: 'Movimenti',
            subtitle: 'Elenco spese',
          ),

          const SizedBox(height: AppSpacing.sm),

          ...expenses.map(
                (expense) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: ExpenseTile(
                expense: expense,
                onTap: () => openEditExpensePage(context, expense),
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => openNewExpensePage(context),
        icon: const Icon(Icons.add),
        label: const Text('Spesa'),
      ),
    );
  }
}