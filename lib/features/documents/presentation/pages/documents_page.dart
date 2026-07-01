import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/document_category_extensions.dart';
import '../../../../core/services/file_storage_service.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_empty_state.dart';
import '../../../trips/domain/entities/trip.dart';
import '../../domain/entities/travel_document.dart';
import '../providers/document_provider.dart';
import 'document_preview_page.dart';
import 'new_document_page.dart';

class DocumentsPage extends ConsumerWidget {
  final Trip trip;

  const DocumentsPage({
    super.key,
    required this.trip,
  });

  Future<void> confirmDeleteDocument(
      BuildContext context,
      WidgetRef ref,
      String tripId,
      TravelDocument document,
      ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Eliminare documento?'),
        content: Text(
          'Vuoi eliminare "${document.title}"?\n\n'
              'Il file verrà rimosso definitivamente.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annulla'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Elimina'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    await const FileStorageService().deleteFile(document.filePath);

    await ref
        .read(documentsProvider(tripId).notifier)
        .deleteDocument(document.id);

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Documento eliminato'),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documents = ref.watch(documentsProvider(trip.id));

    return Scaffold(
      appBar: AppBar(
        title: Text('${trip.title} • Documenti'),
      ),
      body: documents.isEmpty
          ? Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Center(
          child: AppEmptyState(
            icon: Icons.description_outlined,
            title: 'Nessun documento',
            message: 'Aggiungi passaporti, voucher, biglietti o PDF.',
            actionLabel: 'Aggiungi documento',
            actionIcon: Icons.add,
            onAction: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => NewDocumentPage(
                    tripId: trip.id,
                  ),
                ),
              );
            },
          ),
        ),
      )
          : ListView.separated(
        padding: const EdgeInsets.all(AppSpacing.lg),
        itemCount: documents.length,
        separatorBuilder: (_, _) =>
        const SizedBox(height: AppSpacing.sm),
        itemBuilder: (context, index) {
          final document = documents[index];

          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor:
                document.category.color.withValues(alpha: 0.15),
                child: Icon(
                  document.category.icon,
                  color: document.category.color,
                ),
              ),
              title: Text(document.title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(document.category.label),
                  const SizedBox(height: 2),
                  Text(
                    '${(document.fileSize / 1024).toStringAsFixed(1)} KB',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline),
                tooltip: 'Elimina documento',
                onPressed: () => confirmDeleteDocument(
                  context,
                  ref,
                  trip.id,
                  document,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DocumentPreviewPage(
                      document: document,
                    ),
                  ),
                );
              },
              onLongPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NewDocumentPage(
                      tripId: trip.id,
                      document: document,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => NewDocumentPage(
                tripId: trip.id,
              ),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Documento'),
      ),
    );
  }
}