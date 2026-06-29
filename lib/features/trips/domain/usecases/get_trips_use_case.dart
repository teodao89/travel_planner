import '../entities/trip.dart';
import '../repositories/trip_repository.dart';

class GetTripsUseCase {
  final TripRepository repository;

  GetTripsUseCase(this.repository);

  List<Trip> execute() {
    return repository.getTrips();
  }
}