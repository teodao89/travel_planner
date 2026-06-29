import '../repositories/trip_repository.dart';

class DeleteTripUseCase {
  final TripRepository repository;

  DeleteTripUseCase(this.repository);

  void execute(String id) {
    repository.deleteTrip(id);
  }
}