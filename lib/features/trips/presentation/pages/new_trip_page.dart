import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../domain/entities/trip.dart';
import '../providers/trip_provider.dart';

class NewTripPage extends ConsumerStatefulWidget {
  const NewTripPage({super.key});

  @override
  ConsumerState<NewTripPage> createState() => _NewTripPageState();
}

class _NewTripPageState extends ConsumerState<NewTripPage> {
  final titleController = TextEditingController();
  final destinationController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;

  @override
  void dispose() {
    titleController.dispose();
    destinationController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    super.dispose();
  }

  Future<void> pickStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked == null) return;

    setState(() {
      startDate = picked;
      startDateController.text = DateFormat('dd/MM/yyyy').format(picked);

      if (endDate != null && endDate!.isBefore(picked)) {
        endDate = null;
        endDateController.clear();
      }
    });
  }

  Future<void> pickEndDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: endDate ?? startDate ?? DateTime.now(),
      firstDate: startDate ?? DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked == null) return;

    setState(() {
      endDate = picked;
      endDateController.text = DateFormat('dd/MM/yyyy').format(picked);
    });
  }

  void saveTrip() {
    final title = titleController.text.trim();
    final destination = destinationController.text.trim();

    if (title.isEmpty || destination.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Compila titolo e destinazione del viaggio.'),
        ),
      );
      return;
    }

    final trip = Trip(
      id: const Uuid().v4(),
      title: title,
      destination: destination,
      startDate: startDate,
      endDate: endDate,
      emoji: '🌍',
      colorValue: 0xFF3F51B5,
    );

    ref.read(tripListProvider.notifier).addTrip(trip);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuovo viaggio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            AppTextField(
              controller: titleController,
              label: 'Titolo viaggio',
              icon: Icons.luggage,
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              controller: destinationController,
              label: 'Destinazione',
              icon: Icons.place_outlined,
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              controller: startDateController,
              label: 'Data inizio',
              icon: Icons.calendar_today_outlined,
              readOnly: true,
              onTap: pickStartDate,
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              controller: endDateController,
              label: 'Data fine',
              icon: Icons.event_outlined,
              readOnly: true,
              onTap: pickEndDate,
            ),
            const Spacer(),
            AppButton(
              label: 'Salva viaggio',
              icon: Icons.save,
              fullWidth: true,
              onPressed: saveTrip,
            ),
          ],
        ),
      ),
    );
  }
}