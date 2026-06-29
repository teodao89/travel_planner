import 'package:flutter/material.dart';

import '../../features/budget/domain/entities/expense.dart';

extension ExpenseCategoryExtension on ExpenseCategory {
  String get label {
    switch (this) {
      case ExpenseCategory.hotel:
        return 'Hotel';

      case ExpenseCategory.transport:
        return 'Trasporti';

      case ExpenseCategory.food:
        return 'Cibo';

      case ExpenseCategory.activity:
        return 'Attività';

      case ExpenseCategory.shopping:
        return 'Shopping';

      case ExpenseCategory.other:
        return 'Altro';
    }
  }

  IconData get icon {
    switch (this) {
      case ExpenseCategory.hotel:
        return Icons.hotel;

      case ExpenseCategory.transport:
        return Icons.directions_car;

      case ExpenseCategory.food:
        return Icons.restaurant;

      case ExpenseCategory.activity:
        return Icons.local_activity;

      case ExpenseCategory.shopping:
        return Icons.shopping_bag;

      case ExpenseCategory.other:
        return Icons.payments_outlined;
    }
  }

  Color get color {
    switch (this) {
      case ExpenseCategory.hotel:
        return Colors.indigo;

      case ExpenseCategory.transport:
        return Colors.blue;

      case ExpenseCategory.food:
        return Colors.orange;

      case ExpenseCategory.activity:
        return Colors.green;

      case ExpenseCategory.shopping:
        return Colors.purple;

      case ExpenseCategory.other:
        return Colors.grey;
    }
  }
}