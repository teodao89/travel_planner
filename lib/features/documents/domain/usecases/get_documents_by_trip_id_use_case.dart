import '../entities/travel_document.dart';
import '../repositories/document_repository.dart';

class GetDocumentsByTripIdUseCase {
  final DocumentRepository repository;

  GetDocumentsByTripIdUseCase(this.repository);

  Future<List<TravelDocument>> call(String tripId) {
    return repository.getDocumentsByTripId(tripId);
  }
}