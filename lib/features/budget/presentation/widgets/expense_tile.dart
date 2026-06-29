import 'package:flutter/material.dart';

import '../../../../core/extensions/expense_category_extensions.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../domain/entities/expense.dart';

class ExpenseTile extends StatelessWidget {
  final Expense expense;
  final VoidCallback? onTap;

  const ExpenseTile({
    super.key,
    required this.expense,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          backgroundColor:
          expense.category.color.withValues(alpha: 0.12),
          child: Icon(
            expense.category.icon,
            color: expense.category.color,
          ),
        ),
        title: Text(
          expense.title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(expense.category.label),
        trailing: Text(
          '€ ${expense.amount.toStringAsFixed(2)}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}