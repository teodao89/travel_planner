import 'package:flutter/material.dart';

import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';

class AppBadge extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color badgeColor;
  final Color? foregroundColor;

  const AppBadge({
    super.key,
    required this.label,
    this.icon,
    this.badgeColor = Colors.indigo,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = foregroundColor ?? badgeColor;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 16,
              color: textColor,
            ),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}