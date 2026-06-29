enum TripStopCategory {
  place,
  activity,
  food,
  transport,
  hotel,
  note,
}

class TripStop {
  final String id;
  final String tripId;
  final String title;
  final String? description;
  final String? address;
  final double? latitude;
  final double? longitude;
  final DateTime? arrivalTime;
  final DateTime? departureTime;
  final TripStopCategory category;
  final int order;
  final DateTime createdAt;
  final DateTime updatedAt;

  TripStop({
    required this.id,
    required this.tripId,
    required this.title,
    this.description,
    this.address,
    this.latitude,
    this.longitude,
    this.arrivalTime,
    this.departureTime,
    this.category = TripStopCategory.place,
    this.order = 0,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();
}