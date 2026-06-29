import '../entities/stop.dart';
import '../repositories/trip_stop_repository.dart';

class AddStopUseCase {
  final TripStopRepository repository;

  AddStopUseCase(this.repository);

  void execute(TripStop stop) {
    repository.addStop(stop);
  }
}