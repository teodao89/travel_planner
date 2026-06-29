import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/trip_repository_impl.dart';
import '../../domain/entities/trip.dart';
import '../../domain/repositories/trip_repository.dart';
import '../../domain/usecases/add_trip_use_case.dart';
import '../../domain/usecases/delete_trip_use_case.dart';
import '../../domain/usecases/get_trips_use_case.dart';

final tripRepositoryProvider = Provider<TripRepository>((ref) {
  return TripRepositoryImpl();
});

final getTripsUseCaseProvider = Provider<GetTripsUseCase>((ref) {
  return GetTripsUseCase(ref.watch(tripRepositoryProvider));
});

final addTripUseCaseProvider = Provider<AddTripUseCase>((ref) {
  return AddTripUseCase(ref.watch(tripRepositoryProvider));
});

final deleteTripUseCaseProvider = Provider<DeleteTripUseCase>((ref) {
  return DeleteTripUseCase(ref.watch(tripRepositoryProvider));
});

final tripListProvider =
StateNotifierProvider<TripListNotifier, List<Trip>>((ref) {
  return TripListNotifier(
    ref.watch(getTripsUseCaseProvider),
    ref.watch(addTripUseCaseProvider),
    ref.watch(deleteTripUseCaseProvider),
  );
});

class TripListNotifier extends StateNotifier<List<Trip>> {
  final GetTripsUseCase _getTrips;
  final AddTripUseCase _addTrip;
  final DeleteTripUseCase _deleteTrip;

  TripListNotifier(
      this._getTrips,
      this._addTrip,
      this._deleteTrip,
      ) : super(_getTrips.execute());

  void addTrip(Trip trip) {
    _addTrip.execute(trip);
    state = _getTrips.execute();
  }

  void deleteTrip(String id) {
    _deleteTrip.execute(id);
    state = _getTrips.execute();
  }
}