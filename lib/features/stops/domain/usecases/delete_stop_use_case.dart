import '../repositories/trip_stop_repository.dart';

class DeleteStopUseCase {
  final TripStopRepository repository;

  DeleteStopUseCase(this.repository);

  void execute(String id) {
    repository.deleteStop(id);
  }
}