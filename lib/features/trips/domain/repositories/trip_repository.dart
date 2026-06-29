import '../entities/trip.dart';

abstract class TripRepository {
  List<Trip> getTrips();

  void addTrip(Trip trip);

  void deleteTrip(String id);
}