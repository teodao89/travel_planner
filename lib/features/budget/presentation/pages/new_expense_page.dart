import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/extensions/expense_category_extensions.dart';
import '../../../../core/services/app_snackbar_service.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../domain/entities/expense.dart';
import '../providers/expense_provider.dart';

class NewExpensePage extends ConsumerStatefulWidget {
  final String tripId;
  final Expense? expense;

  const NewExpensePage({
    super.key,
    required this.tripId,
    this.expense,
  });

  @override
  ConsumerState<NewExpensePage> createState() => _NewExpensePageState();
}

class _NewExpensePageState extends ConsumerState<NewExpensePage> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final notesController = TextEditingController();

  ExpenseCategory selectedCategory = ExpenseCategory.other;

  bool get isEditing => widget.expense != null;

  @override
  void initState() {
    super.initState();

    final expense = widget.expense;
    if (expense == null) return;

    titleController.text = expense.title;
    amountController.text = expense.amount.toStringAsFixed(2);
    notesController.text = expense.notes ?? '';
    selectedCategory = expense.category;
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    notesController.dispose();
    super.dispose();
  }

  double? parseAmount(String value) {
    return double.tryParse(value.trim().replaceAll(',', '.'));
  }

  void saveExpense() {
    final title = titleController.text.trim();
    final amount = parseAmount(amountController.text);
    final notes = notesController.text.trim();

    if (title.isEmpty) {
      AppSnackbarService.showError(context, 'Inserisci il titolo della spesa.');
      return;
    }

    if (amount == null || amount <= 0) {
      AppSnackbarService.showError(context, 'Inserisci un importo valido.');
      return;
    }

    final oldExpense = widget.expense;

    final expense = Expense(
      id: oldExpense?.id ?? const Uuid().v4(),
      tripId: widget.tripId,
      title: title,
      amount: amount,
      category: selectedCategory,
      date: oldExpense?.date ?? DateTime.now(),
      notes: notes.isEmpty ? null : notes,
      createdAt: oldExpense?.createdAt,
      updatedAt: DateTime.now(),
    );

    final notifier = ref.read(expensesProvider(widget.tripId).notifier);

    if (isEditing) {
      notifier.updateExpense(expense);
    } else {
      notifier.addExpense(expense);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Modifica spesa' : 'Nuova spesa'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          AppTextField(
            controller: titleController,
            label: 'Titolo spesa',
            icon: Icons.receipt_long_outlined,
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: amountController,
            label: 'Importo',
            icon: Icons.euro,
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          DropdownButtonFormField<ExpenseCategory>(
            initialValue: selectedCategory,
            decoration: const InputDecoration(
              labelText: 'Categoria',
              border: OutlineInputBorder(),
            ),
            items: ExpenseCategory.values.map((category) {
              return DropdownMenuItem(
                value: category,
                child: Row(
                  children: [
                    Icon(category.icon, color: category.color),
                    const SizedBox(width: AppSpacing.sm),
                    Text(category.label),
                  ],
                ),
              );
            }).toList(),
            onChanged: (value) {
              if (value == null) return;
              setState(() {
                selectedCategory = value;
              });
            },
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: notesController,
            label: 'Note',
            icon: Icons.notes_outlined,
            maxLines: 3,
          ),
          const SizedBox(height: AppSpacing.xl),
          AppButton(
            label: isEditing ? 'Salva modifiche' : 'Salva spesa',
            icon: Icons.save,
            fullWidth: true,
            onPressed: saveExpense,
          ),
        ],
      ),
    );
  }
}