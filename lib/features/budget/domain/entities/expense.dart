enum ExpenseCategory {
  hotel,
  transport,
  food,
  activity,
  shopping,
  other,
}

class Expense {
  final String id;
  final String tripId;

  final String title;
  final double amount;

  final ExpenseCategory category;

  final DateTime date;

  final String? notes;

  final DateTime createdAt;
  final DateTime updatedAt;

  Expense({
    required this.id,
    required this.tripId,
    required this.title,
    required this.amount,
    this.category = ExpenseCategory.other,
    required this.date,
    this.notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();
}