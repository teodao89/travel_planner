import 'package:isar_community/isar.dart';

import '../../domain/entities/travel_document.dart';

part 'travel_document_isar_model.g.dart';

@collection
class TravelDocumentIsarModel {
  Id isarId = Isar.autoIncrement;

  late String id;
  late String tripId;

  late String title;
  late int categoryIndex;

  late String filePath;
  String? thumbnailPath;
  late String mimeType;
  late int fileSize;

  String? notes;

  late DateTime createdAt;
  late DateTime updatedAt;

  TravelDocument toEntity() {
    return TravelDocument(
      id: id,
      tripId: tripId,
      title: title,
      category: DocumentCategory.values[categoryIndex],
      filePath: filePath,
      thumbnailPath: thumbnailPath,
      mimeType: mimeType,
      fileSize: fileSize,
      notes: notes,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  static TravelDocumentIsarModel fromEntity(TravelDocument document) {
    return TravelDocumentIsarModel()
      ..id = document.id
      ..tripId = document.tripId
      ..title = document.title
      ..categoryIndex = document.category.index
      ..filePath = document.filePath
      ..thumbnailPath = document.thumbnailPath
      ..mimeType = document.mimeType
      ..fileSize = document.fileSize
      ..notes = document.notes
      ..createdAt = document.createdAt
      ..updatedAt = document.updatedAt;
  }
}