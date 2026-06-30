import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/document_repository_impl.dart';
import '../../domain/entities/travel_document.dart';
import '../../domain/repositories/document_repository.dart';
import '../../domain/usecases/add_document_use_case.dart';
import '../../domain/usecases/delete_document_use_case.dart';
import '../../domain/usecases/get_documents_by_trip_id_use_case.dart';
import '../../domain/usecases/update_document_use_case.dart';

final documentRepositoryProvider = Provider<DocumentRepository>((ref) {
  return DocumentRepositoryImpl();
});

final getDocumentsByTripIdUseCaseProvider =
Provider<GetDocumentsByTripIdUseCase>((ref) {
  return GetDocumentsByTripIdUseCase(
    ref.watch(documentRepositoryProvider),
  );
});

final addDocumentUseCaseProvider = Provider<AddDocumentUseCase>((ref) {
  return AddDocumentUseCase(
    ref.watch(documentRepositoryProvider),
  );
});

final updateDocumentUseCaseProvider = Provider<UpdateDocumentUseCase>((ref) {
  return UpdateDocumentUseCase(
    ref.watch(documentRepositoryProvider),
  );
});

final deleteDocumentUseCaseProvider = Provider<DeleteDocumentUseCase>((ref) {
  return DeleteDocumentUseCase(
    ref.watch(documentRepositoryProvider),
  );
});

final documentsProvider =
StateNotifierProvider.family<DocumentsNotifier, List<TravelDocument>, String>(
      (ref, tripId) {
    return DocumentsNotifier(
      tripId: tripId,
      getDocuments: ref.watch(getDocumentsByTripIdUseCaseProvider),
      addDocumentUseCase: ref.watch(addDocumentUseCaseProvider),
      updateDocumentUseCase: ref.watch(updateDocumentUseCaseProvider),
      deleteDocumentUseCase: ref.watch(deleteDocumentUseCaseProvider),
    );
  },
);

class DocumentsNotifier extends StateNotifier<List<TravelDocument>> {
  final String tripId;
  final GetDocumentsByTripIdUseCase getDocuments;
  final AddDocumentUseCase addDocumentUseCase;
  final UpdateDocumentUseCase updateDocumentUseCase;
  final DeleteDocumentUseCase deleteDocumentUseCase;

  DocumentsNotifier({
    required this.tripId,
    required this.getDocuments,
    required this.addDocumentUseCase,
    required this.updateDocumentUseCase,
    required this.deleteDocumentUseCase,
  }) : super([]) {
    loadDocuments();
  }

  Future<void> loadDocuments() async {
    state = await getDocuments.call(tripId);
  }

  Future<void> addDocument(TravelDocument document) async {
    await addDocumentUseCase.call(document);
    await loadDocuments();
  }

  Future<void> updateDocument(TravelDocument document) async {
    await updateDocumentUseCase.call(document);
    await loadDocuments();
  }

  Future<void> deleteDocument(String id) async {
    await deleteDocumentUseCase.call(id);
    await loadDocuments();
  }
}