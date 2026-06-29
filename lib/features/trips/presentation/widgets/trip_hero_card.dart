import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_badge.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../domain/entities/trip.dart';

class TripHeroCard extends StatelessWidget {
  final Trip trip;
  final VoidCallback? onOpen;

  const TripHeroCard({
    super.key,
    required this.trip,
    this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    final tripColor = Color(trip.colorValue);

    final dateText = trip.startDate == null || trip.endDate == null
        ? 'Date non impostate'
        : '${DateFormat('dd/MM/yyyy').format(trip.startDate!)} → ${DateFormat('dd/MM/yyyy').format(trip.endDate!)}';

    return AppCard(
      onTap: onOpen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 38,
                backgroundColor: tripColor.withValues(alpha: 0.12),
                child: Text(
                  trip.emoji,
                  style: const TextStyle(fontSize: 34),
                ),
              ),
              const Spacer(),
              AppBadge(
                label: trip.status.label,
                icon: Icons.edit_note,
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          Text(
            trip.title.toUpperCase(),
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              letterSpacing: .6,
            ),
          ),

          const SizedBox(height: AppSpacing.xs),

          Row(
            children: [
              const Icon(Icons.place_outlined, size: 18),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  trip.destination,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          Row(
            children: [
              const Icon(Icons.calendar_today_outlined, size: 18),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  dateText,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.md),

          Row(
            children: [
              _HeroInfo(
                icon: Icons.route_outlined,
                label: 'Tappe',
                value: trip.stopCount.toString(),
              ),
              const SizedBox(width: AppSpacing.md),
              _HeroInfo(
                icon: Icons.account_balance_wallet_outlined,
                label: 'Budget',
                value: '€${trip.budget.toStringAsFixed(0)}',
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          Align(
            alignment: Alignment.centerRight,
            child: AppButton(
              label: 'Apri viaggio',
              icon: Icons.arrow_forward,
              onPressed: onOpen,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _HeroInfo({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: AppSpacing.sm),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}