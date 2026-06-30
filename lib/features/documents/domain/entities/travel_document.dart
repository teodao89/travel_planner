enum DocumentCategory {
  passport,
  boardingPass,
  hotelVoucher,
  insurance,
  trainTicket,
  museumTicket,
  visa,
  other,
}

enum DocumentType {
  image,
  pdf,
  other,
}

class TravelDocument {
  final String id;
  final String tripId;

  final String title;
  final DocumentCategory category;

  final String filePath;
  final String? thumbnailPath;
  final String mimeType;
  final int fileSize;

  final String? notes;

  final DateTime createdAt;
  final DateTime updatedAt;

  TravelDocument({
    required this.id,
    required this.tripId,
    required this.title,
    required this.filePath,
    required this.mimeType,
    required this.fileSize,
    this.category = DocumentCategory.other,
    this.thumbnailPath,
    this.notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  DocumentType get type {
    if (mimeType.startsWith('image/')) return DocumentType.image;
    if (mimeType == 'application/pdf') return DocumentType.pdf;
    return DocumentType.other;
  }
}