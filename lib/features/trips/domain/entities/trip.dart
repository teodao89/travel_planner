import '../../../../core/enums/trip_status.dart';

class Trip {
  final String id;
  final String title;
  final String destination;
  final DateTime? startDate;
  final DateTime? endDate;
  final String emoji;
  final int colorValue;
  final TripStatus status;
  final String? coverImage;
  final String? notes;
  final int stopCount;
  final double budget;
  final DateTime createdAt;
  final DateTime updatedAt;

  Trip({
    required this.id,
    required this.title,
    required this.destination,
    this.startDate,
    this.endDate,
    this.emoji = '🌍',
    this.colorValue = 0xFF3F51B5,
    this.status = TripStatus.draft,
    this.coverImage,
    this.notes,
    this.stopCount = 0,
    this.budget = 0,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();
}