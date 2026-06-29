import '../entities/stop.dart';

abstract class TripStopRepository {
  List<TripStop> getStopsByTripId(String tripId);

  void addStop(TripStop stop);

  void updateStop(TripStop stop);

  void deleteStop(String id);
}