import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/theme/app_spacing.dart';
import '../../../domain/entities/trip.dart';

class TripHeroHeader extends StatelessWidget {
  final Trip trip;

  const TripHeroHeader({
    super.key,
    required this.trip,
  });

  @override
  Widget build(BuildContext context) {
    final tripColor = Color(trip.colorValue);

    final dateText = trip.startDate == null || trip.endDate == null
        ? 'Date non impostate'
        : '${DateFormat('dd/MM/yyyy').format(trip.startDate!)} - ${DateFormat('dd/MM/yyyy').format(trip.endDate!)}';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: tripColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 34,
            backgroundColor: tripColor.withValues(alpha: 0.12),
            child: Text(
              trip.emoji,
              style: const TextStyle(fontSize: 32),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            trip.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            trip.destination,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              const Icon(
                Icons.calendar_today_outlined,
                color: Colors.white,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                dateText,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}