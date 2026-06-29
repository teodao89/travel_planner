import 'package:flutter/material.dart';

import '../../features/stops/domain/entities/stop.dart';

extension TripStopCategoryExtensions on TripStopCategory {
  String get label {
    switch (this) {
      case TripStopCategory.place:
        return 'Luogo';
      case TripStopCategory.activity:
        return 'Attività';
      case TripStopCategory.food:
        return 'Cibo';
      case TripStopCategory.transport:
        return 'Trasporto';
      case TripStopCategory.hotel:
        return 'Hotel';
      case TripStopCategory.note:
        return 'Nota';
    }
  }

  IconData get icon {
    switch (this) {
      case TripStopCategory.place:
        return Icons.place_outlined;
      case TripStopCategory.activity:
        return Icons.local_activity_outlined;
      case TripStopCategory.food:
        return Icons.restaurant_outlined;
      case TripStopCategory.transport:
        return Icons.directions_bus_outlined;
      case TripStopCategory.hotel:
        return Icons.hotel_outlined;
      case TripStopCategory.note:
        return Icons.notes_outlined;
    }
  }

  Color get color {
    switch (this) {
      case TripStopCategory.place:
        return Colors.indigo;
      case TripStopCategory.activity:
        return Colors.green;
      case TripStopCategory.food:
        return Colors.orange;
      case TripStopCategory.transport:
        return Colors.blueGrey;
      case TripStopCategory.hotel:
        return Colors.purple;
      case TripStopCategory.note:
        return Colors.grey;
    }
  }
}