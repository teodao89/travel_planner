import '../entities/travel_document.dart';
import '../repositories/document_repository.dart';

class UpdateDocumentUseCase {
  final DocumentRepository repository;

  UpdateDocumentUseCase(this.repository);

  Future<void> call(TravelDocument document) {
    return repository.updateDocument(document);
  }
}