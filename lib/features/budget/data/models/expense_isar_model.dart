import 'package:isar_community/isar.dart';

import '../../domain/entities/expense.dart';

part 'expense_isar_model.g.dart';

@collection
class ExpenseIsarModel {
  Id isarId = Isar.autoIncrement;

  late String id;
  late String tripId;

  late String title;
  late double amount;

  late int categoryIndex;

  late DateTime date;

  String? notes;

  late DateTime createdAt;
  late DateTime updatedAt;

  Expense toEntity() {
    return Expense(
      id: id,
      tripId: tripId,
      title: title,
      amount: amount,
      category: ExpenseCategory.values[categoryIndex],
      date: date,
      notes: notes,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  static ExpenseIsarModel fromEntity(Expense expense) {
    return ExpenseIsarModel()
      ..id = expense.id
      ..tripId = expense.tripId
      ..title = expense.title
      ..amount = expense.amount
      ..categoryIndex = expense.category.index
      ..date = expense.date
      ..notes = expense.notes
      ..createdAt = expense.createdAt
      ..updatedAt = expense.updatedAt;
  }
}