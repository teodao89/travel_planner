import 'package:isar_community/isar.dart';

import '../../../../core/enums/trip_status.dart';
import '../../domain/entities/trip.dart';

part 'trip_isar_model.g.dart';

@collection
class TripIsarModel {
  Id isarId = Isar.autoIncrement;

  late String id;
  late String title;
  late String destination;

  DateTime? startDate;
  DateTime? endDate;

  late String emoji;
  late int colorValue;
  late int statusIndex;

  String? coverImage;
  String? notes;

  late int stopCount;
  late double budget;

  late DateTime createdAt;
  late DateTime updatedAt;

  Trip toEntity() {
    return Trip(
      id: id,
      title: title,
      destination: destination,
      startDate: startDate,
      endDate: endDate,
      emoji: emoji,
      colorValue: colorValue,
      status: TripStatus.values[statusIndex],
      coverImage: coverImage,
      notes: notes,
      stopCount: stopCount,
      budget: budget,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  static TripIsarModel fromEntity(Trip trip) {
    return TripIsarModel()
      ..id = trip.id
      ..title = trip.title
      ..destination = trip.destination
      ..startDate = trip.startDate
      ..endDate = trip.endDate
      ..emoji = trip.emoji
      ..colorValue = trip.colorValue
      ..statusIndex = trip.status.index
      ..coverImage = trip.coverImage
      ..notes = trip.notes
      ..stopCount = trip.stopCount
      ..budget = trip.budget
      ..createdAt = trip.createdAt
      ..updatedAt = trip.updatedAt;
  }
}