import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import 'app_card.dart';

class AppTimelineTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? time;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;
  final Widget? trailing;

  const AppTimelineTile({
    super.key,
    required this.title,
    this.subtitle,
    this.time,
    required this.icon,
    required this.color,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: color.withValues(alpha: .12),
                child: Icon(
                  icon,
                  color: color,
                ),
              ),
              Container(
                width: 2,
                height: 50,
                color: Colors.grey.shade300,
              ),
            ],
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (time != null)
                  Text(
                    time!,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (subtitle != null)
                  Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.xs),
                    child: Text(
                      subtitle!,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          trailing ?? const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}