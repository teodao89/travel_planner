import 'package:flutter/material.dart';

import '../../../../../core/theme/app_spacing.dart';
import '../../../../../shared/widgets/app_button.dart';
import '../../../../../shared/widgets/app_card.dart';

class TripQuickActions extends StatelessWidget {
  final VoidCallback? onAddStop;
  final VoidCallback? onAddExpense;
  final VoidCallback? onAddDocument;

  const TripQuickActions({
    super.key,
    this.onAddStop,
    this.onAddExpense,
    this.onAddDocument,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        children: [
          AppButton(
            label: 'Aggiungi tappa',
            icon: Icons.add_location_alt_outlined,
            onPressed: onAddStop,
            fullWidth: true,
          ),
          const SizedBox(height: AppSpacing.sm),
          AppButton(
            label: 'Aggiungi spesa',
            icon: Icons.account_balance_wallet_outlined,
            onPressed: onAddExpense,
            fullWidth: true,
          ),
          const SizedBox(height: AppSpacing.sm),
          AppButton(
            label: 'Aggiungi documento',
            icon: Icons.description_outlined,
            onPressed: onAddDocument,
            fullWidth: true,
          ),
        ],
      ),
    );
  }
}