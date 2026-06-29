import '../entities/stop.dart';
import '../repositories/trip_stop_repository.dart';

class UpdateStopUseCase {
  final TripStopRepository repository;

  UpdateStopUseCase(this.repository);

  void execute(TripStop stop) {
    repository.updateStop(stop);
  }
}