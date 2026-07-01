import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/services/app_snackbar_service.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/travel_document.dart';

class DocumentPreviewPage extends StatelessWidget {
  final TravelDocument document;

  const DocumentPreviewPage({
    super.key,
    required this.document,
  });

  bool get isPdf => document.mimeType == 'application/pdf';

  bool get isImage => document.mimeType.startsWith('image/');

  Future<void> shareDocument(BuildContext context) async {
    final file = File(document.filePath);

    if (!await file.exists()) {
      if (context.mounted) {
        AppSnackbarService.showError(
          context,
          'File non trovato.',
        );
      }
      return;
    }

    await Share.shareXFiles(
      [
        XFile(
          file.path,
          mimeType: document.mimeType,
          name: document.title,
        ),
      ],
      text: document.title,
    );
  }

  @override
  Widget build(BuildContext context) {
    final file = File(document.filePath);

    return Scaffold(
      appBar: AppBar(
        title: Text(document.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            tooltip: 'Condividi',
            onPressed: () => shareDocument(context),
          ),
        ],
      ),
      body: FutureBuilder<bool>(
        future: file.exists(),
        builder: (context, snapshot) {
          final exists = snapshot.data ?? false;

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!exists) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.lg),
                child: Text(
                  'File non trovato.',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          if (isImage) {
            return InteractiveViewer(
              child: Center(
                child: Image.file(file),
              ),
            );
          }

          if (isPdf) {
            return PdfViewer.file(file.path);
          }

          return const Center(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: Text(
                'Tipo di documento non supportato.',
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
      ),
    );
  }
}