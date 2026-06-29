import '../entities/expense.dart';
import '../repositories/expense_repository.dart';

class UpdateExpenseUseCase {
  final ExpenseRepository repository;

  UpdateExpenseUseCase(this.repository);

  void execute(Expense expense) {
    repository.updateExpense(expense);
  }
}