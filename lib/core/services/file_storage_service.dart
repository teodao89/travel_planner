import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class FileStorageService {
  const FileStorageService();

  Future<Directory> _documentsDirectory(String tripId) async {
    final appDir = await getApplicationDocumentsDirectory();

    final documentsDir = Directory(
      p.join(appDir.path, 'documents', tripId),
    );

    if (!await documentsDir.exists()) {
      await documentsDir.create(recursive: true);
    }

    return documentsDir;
  }

  Future<String> saveFile({
    required String sourcePath,
    required String tripId,
  }) async {
    final source = File(sourcePath);

    if (!await source.exists()) {
      throw Exception('File non trovato: $sourcePath');
    }

    final folder = await _documentsDirectory(tripId);
    final fileName = p.basename(sourcePath);

    final destination = File(
      p.join(folder.path, fileName),
    );

    await source.copy(destination.path);

    return destination.path;
  }

  Future<void> deleteFile(String filePath) async {
    final file = File(filePath);

    if (await file.exists()) {
      await file.delete();
    }
  }

  Future<bool> exists(String filePath) {
    return File(filePath).exists();
  }

  File getFile(String filePath) {
    return File(filePath);
  }
}