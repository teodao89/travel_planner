import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_empty_state.dart';
import '../../../trips/domain/entities/trip.dart';
import '../providers/document_provider.dart';
import 'document_preview_page.dart';
import 'new_document_page.dart';
import '../../../../core/extensions/document_category_extensions.dart';

class DocumentsPage extends ConsumerWidget {
  final Trip trip;

  const DocumentsPage({
    super.key,
    required this.trip,
  });

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
                backgroundColor: document.category.color.withValues(alpha: 0.15),
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
              trailing: const Icon(Icons.chevron_right),
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