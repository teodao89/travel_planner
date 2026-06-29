import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_stat.dart';

class DashboardCard extends StatelessWidget {
  final int tripCount;
  final int stopCount;
  final double budget;

  const DashboardCard({
    super.key,
    required this.tripCount,
    required this.stopCount,
    required this.budget,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        children: [
          AppStat(
            icon: Icons.flight_takeoff,
            value: tripCount.toString(),
            label: 'Viaggi',
          ),
          const SizedBox(width: AppSpacing.md),
          AppStat(
            icon: Icons.place_outlined,
            value: stopCount.toString(),
            label: 'Tappe',
          ),
          const SizedBox(width: AppSpacing.md),
          AppStat(
            icon: Icons.account_balance_wallet_outlined,
            value: '€${budget.toStringAsFixed(0)}',
            label: 'Budget',
          ),
        ],
      ),
    );
  }
}