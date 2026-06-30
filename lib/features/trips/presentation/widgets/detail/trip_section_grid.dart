import 'package:flutter/material.dart';

import '../../../../../core/theme/app_spacing.dart';
import '../../../../../shared/widgets/app_card.dart';

class TripSectionGrid extends StatelessWidget {
  final VoidCallback? onTimelineTap;
  final VoidCallback? onMapTap;
  final VoidCallback? onBudgetTap;
  final VoidCallback? onDocumentsTap;

  const TripSectionGrid({
    super.key,
    this.onTimelineTap,
    this.onMapTap,
    this.onBudgetTap,
    this.onDocumentsTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: AppSpacing.md,
      mainAxisSpacing: AppSpacing.md,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.15,
      children: [
        _SectionTile(
          icon: Icons.route_outlined,
          title: 'Timeline',
          subtitle: 'Tappe e attività',
          onTap: onTimelineTap,
        ),
        _SectionTile(
          icon: Icons.map_outlined,
          title: 'Mappa',
          subtitle: 'Percorso',
          onTap: onMapTap,
        ),
        const _SectionTile(
          icon: Icons.hotel_outlined,
          title: 'Hotel',
          subtitle: 'Prenotazioni',
        ),
        const _SectionTile(
          icon: Icons.flight_outlined,
          title: 'Voli',
          subtitle: 'Biglietti',
        ),
        _SectionTile(
          icon: Icons.account_balance_wallet_outlined,
          title: 'Budget',
          subtitle: 'Spese',
          onTap: onBudgetTap,
        ),
        _SectionTile(
          icon: Icons.description_outlined,
          title: 'Documenti',
          subtitle: 'Voucher e PDF',
          onTap: onDocumentsTap,
        ),
      ],
    );
  }
}

class _SectionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const _SectionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap ??
              () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$title disponibile prossimamente'),
              ),
            );
          },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 34),
          const SizedBox(height: AppSpacing.md),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}