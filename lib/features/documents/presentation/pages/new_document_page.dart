import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mime/mime.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/extensions/document_category_extensions.dart';
import '../../../../core/services/app_snackbar_service.dart';
import '../../../../core/services/file_storage_service.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../domain/entities/travel_document.dart';
import '../providers/document_provider.dart';

class NewDocumentPage extends ConsumerStatefulWidget {
  final String tripId;
  final TravelDocument? document;

  const NewDocumentPage({
    super.key,
    required this.tripId,
    this.document,
  });

  @override
  ConsumerState<NewDocumentPage> createState() => _NewDocumentPageState();
}

class _NewDocumentPageState extends ConsumerState<NewDocumentPage> {
  final titleController = TextEditingController();
  final filePathController = TextEditingController();
  final notesController = TextEditingController();

  DocumentCategory selectedCategory = DocumentCategory.other;

  bool get isEditing => widget.document != null;

  @override
  void initState() {
    super.initState();

    final document = widget.document;
    if (document == null) return;

    titleController.text = document.title;
    filePathController.text = document.filePath;
    notesController.text = document.notes ?? '';
    selectedCategory = document.category;
  }

  @override
  void dispose() {
    titleController.dispose();
    filePathController.dispose();
    notesController.dispose();
    super.dispose();
  }

  String guessMimeType(String path) {
    final lower = path.toLowerCase();

    if (lower.endsWith('.pdf')) return 'application/pdf';
    if (lower.endsWith('.jpg') || lower.endsWith('.jpeg')) return 'image/jpeg';
    if (lower.endsWith('.png')) return 'image/png';

    return 'application/octet-stream';
  }

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result == null || result.files.single.path == null) return;

    final sourcePath = result.files.single.path!;

    final savedPath = await const FileStorageService().saveFile(
      sourcePath: sourcePath,
      tripId: widget.tripId,
    );

    setState(() {
      filePathController.text = savedPath;
    });

    if (mounted) {
      AppSnackbarService.showSuccess(
        context,
        'File selezionato',
      );
    }
  }

  void saveDocument() {
    final title = titleController.text.trim();
    final filePath = filePathController.text.trim();
    final notes = notesController.text.trim();

    if (title.isEmpty) {
      AppSnackbarService.showError(
        context,
        'Inserisci il titolo del documento.',
      );
      return;
    }

    if (filePath.isEmpty) {
      AppSnackbarService.showError(
        context,
        'Seleziona un file.',
      );
      return;
    }

    final file = File(filePath);
    final oldDocument = widget.document;

    final document = TravelDocument(
      id: oldDocument?.id ?? const Uuid().v4(),
      tripId: widget.tripId,
      title: title,
      category: selectedCategory,
      filePath: filePath,
      thumbnailPath: oldDocument?.thumbnailPath,
      mimeType: lookupMimeType(filePath) ?? guessMimeType(filePath),
      fileSize: file.existsSync() ? file.lengthSync() : 0,
      notes: notes.isEmpty ? null : notes,
      createdAt: oldDocument?.createdAt,
      updatedAt: DateTime.now(),
    );

    final notifier = ref.read(documentsProvider(widget.tripId).notifier);

    if (isEditing) {
      notifier.updateDocument(document);
    } else {
      notifier.addDocument(document);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final hasSelectedFile = filePathController.text.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Modifica documento' : 'Nuovo documento'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          AppTextField(
            controller: titleController,
            label: 'Titolo documento',
            icon: Icons.description_outlined,
          ),

          const SizedBox(height: AppSpacing.md),

          DropdownButtonFormField<DocumentCategory>(
            initialValue: selectedCategory,
            decoration: const InputDecoration(
              labelText: 'Categoria',
              border: OutlineInputBorder(),
            ),
            items: DocumentCategory.values.map((category) {
              return DropdownMenuItem(
                value: category,
                child: Row(
                  children: [
                    Icon(
                      category.icon,
                      color: category.color,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Text(category.label),
                  ],
                ),
              );
            }).toList(),
            onChanged: (value) {
              if (value == null) return;

              setState(() {
                selectedCategory = value;
              });
            },
          ),

          const SizedBox(height: AppSpacing.md),

          AppButton(
            label: hasSelectedFile ? 'File selezionato' : 'Seleziona file',
            icon: Icons.attach_file,
            fullWidth: true,
            onPressed: pickFile,
          ),

          if (hasSelectedFile) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              filePathController.text,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
          ],

          const SizedBox(height: AppSpacing.md),

          AppTextField(
            controller: notesController,
            label: 'Note',
            icon: Icons.notes_outlined,
            maxLines: 3,
          ),

          const SizedBox(height: AppSpacing.xl),

          AppButton(
            label: isEditing ? 'Salva modifiche' : 'Salva documento',
            icon: Icons.save,
            fullWidth: true,
            onPressed: saveDocument,
          ),
        ],
      ),
    );
  }
}