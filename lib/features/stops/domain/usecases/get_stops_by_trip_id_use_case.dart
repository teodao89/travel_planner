import '../entities/stop.dart';
import '../repositories/trip_stop_repository.dart';

class GetStopsByTripIdUseCase {
  final TripStopRepository repository;

  GetStopsByTripIdUseCase(this.repository);

  List<TripStop> execute(String tripId) {
    return repository.getStopsByTripId(tripId);
  }
}