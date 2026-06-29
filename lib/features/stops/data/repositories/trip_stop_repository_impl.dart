import 'package:isar_community/isar.dart';

import '../../../../core/database/isar_service.dart';
import '../../domain/entities/stop.dart';
import '../../domain/repositories/trip_stop_repository.dart';
import '../models/trip_stop_isar_model.dart';

class TripStopRepositoryImpl implements TripStopRepository {
  @override
  List<TripStop> getStopsByTripId(String tripId) {
    final isar = IsarService.instance;

    final models = isar.tripStopIsarModels
        .filter()
        .tripIdEqualTo(tripId)
        .findAllSync();

    final stops = models.map((model) => model.toEntity()).toList();

    stops.sort((a, b) {
      if (a.arrivalTime != null && b.arrivalTime != null) {
        return a.arrivalTime!.compareTo(b.arrivalTime!);
      }

      if (a.arrivalTime != null && b.arrivalTime == null) {
        return -1;
      }

      if (a.arrivalTime == null && b.arrivalTime != null) {
        return 1;
      }

      return a.order.compareTo(b.order);
    });

    return stops;
  }

  @override
  void addStop(TripStop stop) {
    final isar = IsarService.instance;
    final model = TripStopIsarModel.fromEntity(stop);

    isar.writeTxnSync(() {
      isar.tripStopIsarModels.putSync(model);
    });
  }

  @override
  void updateStop(TripStop stop) {
    final isar = IsarService.instance;
    final model = TripStopIsarModel.fromEntity(stop);

    isar.writeTxnSync(() {
      final existing = isar.tripStopIsarModels
          .filter()
          .idEqualTo(stop.id)
          .findFirstSync();

      if (existing != null) {
        model.isarId = existing.isarId;
      }

      isar.tripStopIsarModels.putSync(model);
    });
  }

  @override
  void deleteStop(String id) {
    final isar = IsarService.instance;

    isar.writeTxnSync(() {
      final stop = isar.tripStopIsarModels
          .filter()
          .idEqualTo(id)
          .findFirstSync();

      if (stop != null) {
        isar.tripStopIsarModels.deleteSync(stop.isarId);
      }
    });
  }
}