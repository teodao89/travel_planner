import 'package:isar_community/isar.dart';

import '../../../../core/database/isar_service.dart';
import '../../domain/entities/travel_document.dart';
import '../../domain/repositories/document_repository.dart';
import '../models/travel_document_isar_model.dart';

class DocumentRepositoryImpl implements DocumentRepository {
  final Isar _isar = IsarService.instance;

  @override
  Future<List<TravelDocument>> getDocumentsByTripId(String tripId) async {
    final documents = await _isar.travelDocumentIsarModels
        .filter()
        .tripIdEqualTo(tripId)
        .findAll();

    return documents.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> addDocument(TravelDocument document) async {
    await _isar.writeTxn(() async {
      await _isar.travelDocumentIsarModels.put(
        TravelDocumentIsarModel.fromEntity(document),
      );
    });
  }

  @override
  Future<void> updateDocument(TravelDocument document) async {
    await _isar.writeTxn(() async {
      await _isar.travelDocumentIsarModels.put(
        TravelDocumentIsarModel.fromEntity(document),
      );
    });
  }

  @override
  Future<void> deleteDocument(String id) async {
    final document = await _isar.travelDocumentIsarModels
        .filter()
        .idEqualTo(id)
        .findFirst();

    if (document == null) return;

    await _isar.writeTxn(() async {
      await _isar.travelDocumentIsarModels.delete(document.isarId);
    });
  }
}