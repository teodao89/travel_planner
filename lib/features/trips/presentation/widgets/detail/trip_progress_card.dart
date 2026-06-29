import 'package:flutter/material.dart';

import '../../../../../core/theme/app_spacing.dart';
import '../../../../../shared/widgets/app_card.dart';
import '../../../domain/entities/trip.dart';

class TripProgressCard extends StatelessWidget {
  final Trip trip;

  const TripProgressCard({
    super.key,
    required this.trip,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        children: [
          _ProgressItem(
            icon: Icons.route_outlined,
            label: 'Tappe',
            value: trip.stopCount.toString(),
          ),
          const SizedBox(width: AppSpacing.md),
          _ProgressItem(
            icon: Icons.account_balance_wallet_outlined,
            label: 'Budget',
            value: '€${trip.budget.toStringAsFixed(0)}',
          ),
          const SizedBox(width: AppSpacing.md),
          const _ProgressItem(
            icon: Icons.check_circle_outline,
            label: 'Stato',
            value: 'Bozza',
          ),
        ],
      ),
    );
  }
}

class _ProgressItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ProgressItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 24),
          const SizedBox(height: AppSpacing.sm),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
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
    );
  }
}