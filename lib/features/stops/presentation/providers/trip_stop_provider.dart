import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/trip_stop_repository_impl.dart';
import '../../domain/entities/stop.dart';
import '../../domain/repositories/trip_stop_repository.dart';
import '../../domain/usecases/add_stop_use_case.dart';
import '../../domain/usecases/delete_stop_use_case.dart';
import '../../domain/usecases/get_stops_by_trip_id_use_case.dart';
import '../../domain/usecases/update_stop_use_case.dart';

final tripStopRepositoryProvider = Provider<TripStopRepository>((ref) {
  return TripStopRepositoryImpl();
});

final getStopsByTripIdUseCaseProvider =
Provider<GetStopsByTripIdUseCase>((ref) {
  return GetStopsByTripIdUseCase(ref.watch(tripStopRepositoryProvider));
});

final addStopUseCaseProvider = Provider<AddStopUseCase>((ref) {
  return AddStopUseCase(ref.watch(tripStopRepositoryProvider));
});

final updateStopUseCaseProvider = Provider<UpdateStopUseCase>((ref) {
  return UpdateStopUseCase(ref.watch(tripStopRepositoryProvider));
});

final deleteStopUseCaseProvider = Provider<DeleteStopUseCase>((ref) {
  return DeleteStopUseCase(ref.watch(tripStopRepositoryProvider));
});

final tripStopsProvider =
StateNotifierProvider.family<TripStopsNotifier, List<TripStop>, String>(
      (ref, tripId) {
    return TripStopsNotifier(
      tripId: tripId,
      getStops: ref.watch(getStopsByTripIdUseCaseProvider),
      addStopUseCase: ref.watch(addStopUseCaseProvider),
      updateStopUseCase: ref.watch(updateStopUseCaseProvider),
      deleteStopUseCase: ref.watch(deleteStopUseCaseProvider),
    );
  },
);

class TripStopsNotifier extends StateNotifier<List<TripStop>> {
  final String tripId;
  final GetStopsByTripIdUseCase getStops;
  final AddStopUseCase addStopUseCase;
  final UpdateStopUseCase updateStopUseCase;
  final DeleteStopUseCase deleteStopUseCase;

  TripStopsNotifier({
    required this.tripId,
    required this.getStops,
    required this.addStopUseCase,
    required this.updateStopUseCase,
    required this.deleteStopUseCase,
  }) : super(getStops.execute(tripId));

  void addStop(TripStop stop) {
    addStopUseCase.execute(stop);
    state = getStops.execute(tripId);
  }

  void updateStop(TripStop stop) {
    updateStopUseCase.execute(stop);
    state = getStops.execute(tripId);
  }

  void deleteStop(String id) {
    deleteStopUseCase.execute(id);
    state = getStops.execute(tripId);
  }
}