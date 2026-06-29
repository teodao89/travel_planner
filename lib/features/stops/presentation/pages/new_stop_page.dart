import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/extensions/trip_stop_category_extensions.dart';
import '../../../../core/services/app_snackbar_service.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../domain/entities/stop.dart';
import '../providers/trip_stop_provider.dart';
import '../widgets/place_search_card.dart';

class NewStopPage extends ConsumerStatefulWidget {
  final String tripId;
  final TripStop? stop;

  const NewStopPage({
    super.key,
    required this.tripId,
    this.stop,
  });

  @override
  ConsumerState<NewStopPage> createState() => _NewStopPageState();
}

class _NewStopPageState extends ConsumerState<NewStopPage> {
  final titleController = TextEditingController();
  final addressController = TextEditingController();
  final descriptionController = TextEditingController();
  final timeController = TextEditingController();
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();

  TripStopCategory selectedCategory = TripStopCategory.place;
  TimeOfDay? selectedTime;

  bool get isEditing => widget.stop != null;

  @override
  void initState() {
    super.initState();

    final stop = widget.stop;
    if (stop == null) return;

    titleController.text = stop.title;
    addressController.text = stop.address ?? '';
    descriptionController.text = stop.description ?? '';
    selectedCategory = stop.category;

    if (stop.latitude != null) {
      latitudeController.text = stop.latitude.toString();
    }

    if (stop.longitude != null) {
      longitudeController.text = stop.longitude.toString();
    }

    if (stop.arrivalTime != null) {
      selectedTime = TimeOfDay.fromDateTime(stop.arrivalTime!);
      timeController.text =
      '${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}';
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    addressController.dispose();
    descriptionController.dispose();
    timeController.dispose();
    latitudeController.dispose();
    longitudeController.dispose();
    super.dispose();
  }

  Future<void> pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (picked == null) return;

    setState(() {
      selectedTime = picked;
      timeController.text =
      '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
    });
  }

  DateTime? buildArrivalTime() {
    if (selectedTime == null) return null;

    final baseDate = widget.stop?.arrivalTime ?? DateTime.now();

    return DateTime(
      baseDate.year,
      baseDate.month,
      baseDate.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );
  }

  double? parseCoordinate(String value) {
    final normalized = value.trim().replaceAll(',', '.');

    if (normalized.isEmpty) return null;

    return double.tryParse(normalized);
  }

  void saveStop() {
    final title = titleController.text.trim();
    final address = addressController.text.trim();
    final description = descriptionController.text.trim();

    final latitude = parseCoordinate(latitudeController.text);
    final longitude = parseCoordinate(longitudeController.text);

    if (title.isEmpty) {
      AppSnackbarService.showError(
        context,
        'Inserisci il titolo della tappa.',
      );
      return;
    }

    if (latitudeController.text.trim().isNotEmpty && latitude == null) {
      AppSnackbarService.showError(
        context,
        'Latitudine non valida.',
      );
      return;
    }

    if (longitudeController.text.trim().isNotEmpty && longitude == null) {
      AppSnackbarService.showError(
        context,
        'Longitudine non valida.',
      );
      return;
    }

    final oldStop = widget.stop;

    final stop = TripStop(
      id: oldStop?.id ?? const Uuid().v4(),
      tripId: widget.tripId,
      title: title,
      address: address.isEmpty ? null : address,
      description: description.isEmpty ? null : description,
      latitude: latitude,
      longitude: longitude,
      arrivalTime: buildArrivalTime(),
      departureTime: oldStop?.departureTime,
      category: selectedCategory,
      order: oldStop?.order ?? ref.read(tripStopsProvider(widget.tripId)).length,
      createdAt: oldStop?.createdAt,
      updatedAt: DateTime.now(),
    );

    final notifier = ref.read(tripStopsProvider(widget.tripId).notifier);

    if (isEditing) {
      notifier.updateStop(stop);
    } else {
      notifier.addStop(stop);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Modifica tappa' : 'Nuova tappa'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          AppTextField(
            controller: titleController,
            label: 'Titolo tappa',
            icon: Icons.place_outlined,
          ),
          const SizedBox(height: AppSpacing.md),
          DropdownButtonFormField<TripStopCategory>(
            initialValue: selectedCategory,
            decoration: const InputDecoration(
              labelText: 'Categoria',
              border: OutlineInputBorder(),
            ),
            items: TripStopCategory.values.map((category) {
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
            controller: timeController,
            label: 'Orario arrivo',
            icon: Icons.access_time_outlined,
            readOnly: true,
            onTap: pickTime,
          ),
          PlaceSearchCard(
            onPlaceSelected: (place) {
              addressController.text = place.address;
              latitudeController.text = place.latitude.toString();
              longitudeController.text = place.longitude.toString();

              AppSnackbarService.showSuccess(
                context,
                'Luogo trovato',
              );
            },
          ),

          const SizedBox(height: AppSpacing.md),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: addressController,
            label: 'Indirizzo',
            icon: Icons.location_on_outlined,
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  controller: latitudeController,
                  label: 'Latitudine',
                  icon: Icons.my_location_outlined,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: true,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: AppTextField(
                  controller: longitudeController,
                  label: 'Longitudine',
                  icon: Icons.explore_outlined,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: true,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: descriptionController,
            label: 'Descrizione',
            icon: Icons.notes_outlined,
            maxLines: 3,
          ),
          const SizedBox(height: AppSpacing.xl),
          AppButton(
            label: isEditing ? 'Salva modifiche' : 'Salva tappa',
            icon: Icons.save,
            fullWidth: true,
            onPressed: saveStop,
          ),
        ],
      ),
    );
  }
}