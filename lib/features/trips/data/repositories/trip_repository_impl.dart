import 'package:isar_community/isar.dart';

import '../../../../core/database/isar_service.dart';
import '../../domain/entities/trip.dart';
import '../../domain/repositories/trip_repository.dart';
import '../models/trip_isar_model.dart';

class TripRepositoryImpl implements TripRepository {
  @override
  List<Trip> getTrips() {
    final isar = IsarService.instance;

    final models = isar.tripIsarModels.where().findAllSync();

    return models.map((model) => model.toEntity()).toList();
  }

  @override
  void addTrip(Trip trip) {
    final isar = IsarService.instance;
    final model = TripIsarModel.fromEntity(trip);

    isar.writeTxnSync(() {
      isar.tripIsarModels.putSync(model);
    });
  }

  @override
  void deleteTrip(String id) {
    final isar = IsarService.instance;

    isar.writeTxnSync(() {
      final trip = isar.tripIsarModels
          .filter()
          .idEqualTo(id)
          .findFirstSync();

      if (trip != null) {
        isar.tripIsarModels.deleteSync(trip.isarId);
      }
    });
  }
}