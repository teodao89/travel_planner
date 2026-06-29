import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';

class AppInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const AppInfoRow({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 19),
        const SizedBox(width: AppSpacing.sm),
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