import 'package:flutter/material.dart';

import '../../features/documents/domain/entities/travel_document.dart';

extension DocumentCategoryExtension on DocumentCategory {
  String get label {
    switch (this) {
      case DocumentCategory.passport:
        return 'Passaporto';
      case DocumentCategory.boardingPass:
        return 'Carta d\'imbarco';
      case DocumentCategory.hotelVoucher:
        return 'Voucher hotel';
      case DocumentCategory.insurance:
        return 'Assicurazione';
      case DocumentCategory.trainTicket:
        return 'Biglietto treno';
      case DocumentCategory.museumTicket:
        return 'Biglietto museo';
      case DocumentCategory.visa:
        return 'Visto';
      case DocumentCategory.other:
        return 'Altro';
    }
  }

  IconData get icon {
    switch (this) {
      case DocumentCategory.passport:
        return Icons.badge_outlined;
      case DocumentCategory.boardingPass:
        return Icons.flight_takeoff_outlined;
      case DocumentCategory.hotelVoucher:
        return Icons.hotel_outlined;
      case DocumentCategory.insurance:
        return Icons.health_and_safety_outlined;
      case DocumentCategory.trainTicket:
        return Icons.train_outlined;
      case DocumentCategory.museumTicket:
        return Icons.museum_outlined;
      case DocumentCategory.visa:
        return Icons.public_outlined;
      case DocumentCategory.other:
        return Icons.description_outlined;
    }
  }

  Color get color {
    switch (this) {
      case DocumentCategory.passport:
        return Colors.indigo;
      case DocumentCategory.boardingPass:
        return Colors.blue;
      case DocumentCategory.hotelVoucher:
        return Colors.deepPurple;
      case DocumentCategory.insurance:
        return Colors.green;
      case DocumentCategory.trainTicket:
        return Colors.orange;
      case DocumentCategory.museumTicket:
        return Colors.brown;
      case DocumentCategory.visa:
        return Colors.teal;
      case DocumentCategory.other:
        return Colors.grey;
    }
  }
}