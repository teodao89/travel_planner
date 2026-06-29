import 'package:isar_community/isar.dart';

import '../../domain/entities/stop.dart';

part 'trip_stop_isar_model.g.dart';

@collection
class TripStopIsarModel {
  Id isarId = Isar.autoIncrement;

  late String id;
  late String tripId;
  late String title;

  String? description;
  String? address;

  double? latitude;
  double? longitude;

  DateTime? arrivalTime;
  DateTime? departureTime;

  late int categoryIndex;
  late int order;

  late DateTime createdAt;
  late DateTime updatedAt;

  TripStop toEntity() {
    return TripStop(
      id: id,
      tripId: tripId,
      title: title,
      description: description,
      address: address,
      latitude: latitude,
      longitude: longitude,
      arrivalTime: arrivalTime,
      departureTime: departureTime,
      category: TripStopCategory.values[categoryIndex],
      order: order,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  static TripStopIsarModel fromEntity(TripStop stop) {
    return TripStopIsarModel()
      ..id = stop.id
      ..tripId = stop.tripId
      ..title = stop.title
      ..description = stop.description
      ..address = stop.address
      ..latitude = stop.latitude
      ..longitude = stop.longitude
      ..arrivalTime = stop.arrivalTime
      ..departureTime = stop.departureTime
      ..categoryIndex = stop.category.index
      ..order = stop.order
      ..createdAt = stop.createdAt
      ..updatedAt = stop.updatedAt;
  }
}