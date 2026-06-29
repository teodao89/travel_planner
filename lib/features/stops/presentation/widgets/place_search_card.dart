import 'package:flutter/material.dart';

import '../../../../core/services/geocoding_service.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../core/theme/app_spacing.dart';

class PlaceSearchCard extends StatefulWidget {
  final void Function(GeocodingResult result) onPlaceSelected;

  const PlaceSearchCard({
    super.key,
    required this.onPlaceSelected,
  });

  @override
  State<PlaceSearchCard> createState() => _PlaceSearchCardState();
}

class _PlaceSearchCardState extends State<PlaceSearchCard> {
  final controller = TextEditingController();

  bool loading = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> search() async {
    final query = controller.text.trim();

    if (query.isEmpty) return;

    setState(() {
      loading = true;
    });

    final result = await GeocodingService.search(query);

    if (!mounted) return;

    setState(() {
      loading = false;
    });

    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Luogo non trovato'),
        ),
      );
      return;
    }

    widget.onPlaceSelected(result);
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        children: [
          AppTextField(
            controller: controller,
            label: 'Cerca luogo',
            icon: Icons.search,
          ),

          const SizedBox(height: AppSpacing.md),

          AppButton(
            label: loading ? 'Ricerca...' : 'Cerca',
            icon: Icons.travel_explore,
            fullWidth: true,
            onPressed: loading ? null : search,
          ),
        ],
      ),
    );
  }
}