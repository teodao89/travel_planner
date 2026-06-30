import '../entities/travel_document.dart';

abstract class DocumentRepository {
  Future<List<TravelDocument>> getDocumentsByTripId(String tripId);

  Future<void> addDocument(TravelDocument document);

  Future<void> updateDocument(TravelDocument document);

  Future<void> deleteDocument(String id);
}