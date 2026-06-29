import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../shared/widgets/app_button.dart';
import '../../domain/entities/trip.dart';

class TripCard extends StatelessWidget {
  final Trip trip;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const TripCard({
    super.key,
    required this.trip,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final tripColor = Color(trip.colorValue);

    final dateText = trip.startDate == null || trip.endDate == null
        ? 'Date non impostate'
        : '${DateFormat('dd/MM/yyyy').format(trip.startDate!)} → ${DateFormat('dd/MM/yyyy').format(trip.endDate!)}';

    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: tripColor.withValues(alpha: 0.12),
                    child: Text(
                      trip.emoji,
                      style: const TextStyle(fontSize: 26),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      trip.title.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: onDelete,
                    icon: const Icon(Icons.delete_outline),
                    tooltip: 'Elimina viaggio',
                  ),
                ],
              ),
              const SizedBox(height: 18),
              _InfoRow(
                icon: Icons.place_outlined,
                text: trip.destination,
              ),
              const SizedBox(height: 10),
              _InfoRow(
                icon: Icons.calendar_today_outlined,
                text: dateText,
              ),
              const SizedBox(height: 10),
              _InfoRow(
                icon: Icons.route_outlined,
                text: '${trip.stopCount} tappe',
              ),
              const Divider(height: 32),
              Row(
                children: [
                  _MiniStat(
                    icon: Icons.account_balance_wallet_outlined,
                    label: 'Budget',
                    value: '€ ${trip.budget.toStringAsFixed(0)}',
                  ),
                  const SizedBox(width: 12),
                  _MiniStat(
                    icon: Icons.flag_outlined,
                    label: 'Stato',
                    value: trip.status.label,
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Align(
                alignment: Alignment.centerRight,
                child: AppButton(
                  label: 'Apri',
                  icon: Icons.arrow_forward,
                  onPressed: onTap,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 19),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }
}

class _MiniStat extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _MiniStat({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 8),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    value,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}