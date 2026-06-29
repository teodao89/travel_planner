import 'package:isar_community/isar.dart';

import '../../../../core/database/isar_service.dart';
import '../../domain/entities/expense.dart';
import '../../domain/repositories/expense_repository.dart';
import '../models/expense_isar_model.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  @override
  List<Expense> getExpensesByTripId(String tripId) {
    final isar = IsarService.instance;

    final models = isar.expenseIsarModels
        .filter()
        .tripIdEqualTo(tripId)
        .findAllSync();

    final expenses = models.map((model) => model.toEntity()).toList();

    expenses.sort((a, b) => b.date.compareTo(a.date));

    return expenses;
  }

  @override
  void addExpense(Expense expense) {
    final isar = IsarService.instance;
    final model = ExpenseIsarModel.fromEntity(expense);

    isar.writeTxnSync(() {
      isar.expenseIsarModels.putSync(model);
    });
  }

  @override
  void updateExpense(Expense expense) {
    final isar = IsarService.instance;
    final model = ExpenseIsarModel.fromEntity(expense);

    isar.writeTxnSync(() {
      final existing = isar.expenseIsarModels
          .filter()
          .idEqualTo(expense.id)
          .findFirstSync();

      if (existing != null) {
        model.isarId = existing.isarId;
      }

      isar.expenseIsarModels.putSync(model);
    });
  }

  @override
  void deleteExpense(String id) {
    final isar = IsarService.instance;

    isar.writeTxnSync(() {
      final expense = isar.expenseIsarModels
          .filter()
          .idEqualTo(id)
          .findFirstSync();

      if (expense != null) {
        isar.expenseIsarModels.deleteSync(expense.isarId);
      }
    });
  }
}