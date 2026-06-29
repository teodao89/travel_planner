import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/expense_repository_impl.dart';
import '../../domain/entities/expense.dart';
import '../../domain/repositories/expense_repository.dart';
import '../../domain/usecases/add_expense_use_case.dart';
import '../../domain/usecases/delete_expense_use_case.dart';
import '../../domain/usecases/get_expenses_by_trip_id_use_case.dart';
import '../../domain/usecases/update_expense_use_case.dart';

final expenseRepositoryProvider = Provider<ExpenseRepository>((ref) {
  return ExpenseRepositoryImpl();
});

final getExpensesByTripIdUseCaseProvider =
Provider<GetExpensesByTripIdUseCase>((ref) {
  return GetExpensesByTripIdUseCase(ref.watch(expenseRepositoryProvider));
});

final addExpenseUseCaseProvider = Provider<AddExpenseUseCase>((ref) {
  return AddExpenseUseCase(ref.watch(expenseRepositoryProvider));
});

final updateExpenseUseCaseProvider = Provider<UpdateExpenseUseCase>((ref) {
  return UpdateExpenseUseCase(ref.watch(expenseRepositoryProvider));
});

final deleteExpenseUseCaseProvider = Provider<DeleteExpenseUseCase>((ref) {
  return DeleteExpenseUseCase(ref.watch(expenseRepositoryProvider));
});

final expensesProvider =
StateNotifierProvider.family<ExpensesNotifier, List<Expense>, String>(
      (ref, tripId) {
    return ExpensesNotifier(
      tripId: tripId,
      getExpenses: ref.watch(getExpensesByTripIdUseCaseProvider),
      addExpenseUseCase: ref.watch(addExpenseUseCaseProvider),
      updateExpenseUseCase: ref.watch(updateExpenseUseCaseProvider),
      deleteExpenseUseCase: ref.watch(deleteExpenseUseCaseProvider),
    );
  },
);

class ExpensesNotifier extends StateNotifier<List<Expense>> {
  final String tripId;
  final GetExpensesByTripIdUseCase getExpenses;
  final AddExpenseUseCase addExpenseUseCase;
  final UpdateExpenseUseCase updateExpenseUseCase;
  final DeleteExpenseUseCase deleteExpenseUseCase;

  ExpensesNotifier({
    required this.tripId,
    required this.getExpenses,
    required this.addExpenseUseCase,
    required this.updateExpenseUseCase,
    required this.deleteExpenseUseCase,
  }) : super(getExpenses.execute(tripId));

  void addExpense(Expense expense) {
    addExpenseUseCase.execute(expense);
    state = getExpenses.execute(tripId);
  }

  void updateExpense(Expense expense) {
    updateExpenseUseCase.execute(expense);
    state = getExpenses.execute(tripId);
  }

  void deleteExpense(String id) {
    deleteExpenseUseCase.execute(id);
    state = getExpenses.execute(tripId);
  }
}