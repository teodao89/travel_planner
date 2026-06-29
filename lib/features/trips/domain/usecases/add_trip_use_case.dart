import '../entities/trip.dart';
import '../repositories/trip_repository.dart';

class AddTripUseCase {
  final TripRepository repository;

  AddTripUseCase(this.repository);

  void execute(Trip trip) {
    repository.addTrip(trip);
  }
}