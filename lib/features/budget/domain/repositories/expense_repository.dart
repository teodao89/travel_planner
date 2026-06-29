import '../entities/expense.dart';

abstract class ExpenseRepository {
  List<Expense> getExpensesByTripId(String tripId);

  void addExpense(Expense expense);

  void updateExpense(Expense expense);

  void deleteExpense(String id);
}