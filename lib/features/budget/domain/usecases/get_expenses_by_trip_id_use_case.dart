import '../entities/expense.dart';
import '../repositories/expense_repository.dart';

class GetExpensesByTripIdUseCase {
  final ExpenseRepository repository;

  GetExpensesByTripIdUseCase(this.repository);

  List<Expense> execute(String tripId) {
    return repository.getExpensesByTripId(tripId);
  }
}