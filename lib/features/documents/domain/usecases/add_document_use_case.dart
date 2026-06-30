import '../entities/travel_document.dart';
import '../repositories/document_repository.dart';

class AddDocumentUseCase {
  final DocumentRepository repository;

  AddDocumentUseCase(this.repository);

  Future<void> call(TravelDocument document) {
    return repository.addDocument(document);
  }
}