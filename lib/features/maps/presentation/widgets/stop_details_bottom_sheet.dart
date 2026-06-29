import 'package:flutter/material.dart';

import '../../../../core/extensions/date_time_extensions.dart';
import '../../../../core/extensions/trip_stop_category_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../stops/domain/entities/stop.dart';

class StopDetailsBottomSheet extends StatelessWidget {
  final TripStop stop;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onNavigate;

  const StopDetailsBottomSheet({
    super.key,
    required this.stop,
    this.onEdit,
    this.onDelete,
    this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: AppCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor:
                    stop.category.color.withValues(alpha: 0.12),
                    child: Icon(
                      stop.category.icon,
                      color: stop.category.color,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      stop.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              if (stop.address != null) ...[
                const SizedBox(height: AppSpacing.lg),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_on_outlined),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(stop.address!),
                    ),
                  ],
                ),
              ],

              if (stop.arrivalTime != null) ...[
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    const Icon(Icons.access_time_outlined),
                    const SizedBox(width: AppSpacing.sm),
                    Text(stop.arrivalTime!.toItalianTime()),
                  ],
                ),
              ],

              if (stop.description != null &&
                  stop.description!.trim().isNotEmpty) ...[
                const SizedBox(height: AppSpacing.md),
                Text(
                  stop.description!,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                  ),
                ),
              ],

              const SizedBox(height: AppSpacing.xl),

              AppButton(
                label: 'Modifica',
                icon: Icons.edit_outlined,
                fullWidth: true,
                onPressed: onEdit,
              ),

              const SizedBox(height: AppSpacing.sm),

              AppButton(
                label: 'Apri navigatore',
                icon: Icons.navigation_outlined,
                fullWidth: true,
                onPressed: onNavigate,
              ),

              const SizedBox(height: AppSpacing.sm),

              AppButton(
                label: 'Elimina',
                icon: Icons.delete_outline,
                fullWidth: true,
                onPressed: onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}