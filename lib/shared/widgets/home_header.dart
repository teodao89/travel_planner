import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final int tripCount;

  const HomeHeader({
    super.key,
    required this.tripCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '🌍 Travel Planner',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Buongiorno Matteo 👋',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          tripCount == 0
              ? 'Pronto a pianificare il tuo prossimo viaggio?'
              : 'Hai $tripCount viaggio${tripCount == 1 ? '' : 'i'} programmato${tripCount == 1 ? '' : 'i'}.',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}