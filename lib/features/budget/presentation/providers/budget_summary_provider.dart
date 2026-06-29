import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/expense.dart';
import 'expense_provider.dart';

class BudgetCategorySummary {
  final ExpenseCategory category;
  final double total;
  final int count;

  const BudgetCategorySummary({
    required this.category,
    required this.total,
    required this.count,
  });
}

class BudgetSummary {
  final double total;
  final List<BudgetCategorySummary> categories;

  const BudgetSummary({
    required this.total,
    required this.categories,
  });
}

final budgetSummaryProvider =
Provider.family<BudgetSummary, String>((ref, tripId) {
  final expenses = ref.watch(expensesProvider(tripId));

  final total = expenses.fold<double>(
    0,
        (sum, expense) => sum + expense.amount,
  );

  final categoryMap = <ExpenseCategory, List<Expense>>{};

  for (final expense in expenses) {
    categoryMap.putIfAbsent(expense.category, () => []);
    categoryMap[expense.category]!.add(expense);
  }

  final categories = categoryMap.entries.map((entry) {
    final categoryTotal = entry.value.fold<double>(
      0,
          (sum, expense) => sum + expense.amount,
    );

    return BudgetCategorySummary(
      category: entry.key,
      total: categoryTotal,
      count: entry.value.length,
    );
  }).toList()
    ..sort((a, b) => b.total.compareTo(a.total));

  return BudgetSummary(
    total: total,
    categories: categories,
  );
});