import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../features/stops/data/models/trip_stop_isar_model.dart';
import '../../features/budget/data/models/expense_isar_model.dart';

import '../../../features/trips/data/models/trip_isar_model.dart';
import '../../features/documents/data/models/travel_document_isar_model.dart';

class IsarService {
  static Isar? _isar;
  static Isar get instance {
    if (_isar == null) {
      throw Exception('Isar non inizializzato. Chiama IsarService.open() prima.');
    }

    return _isar!;
  }

  static Future<Isar> open() async {
    if (_isar != null) {
      return _isar!;
    }

    final dir = await getApplicationDocumentsDirectory();

    _isar = await Isar.open(
      [
        TripIsarModelSchema,
        TripStopIsarModelSchema,
        ExpenseIsarModelSchema,
        TravelDocumentIsarModelSchema,
      ],
      directory: dir.path,
    );

    return _isar!;
  }
}