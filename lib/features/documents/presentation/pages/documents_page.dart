import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_empty_state.dart';
import '../../../trips/domain/entities/trip.dart';
import '../providers/document_provider.dart';
import 'new_document_page.dart';

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
              leading: Icon(
                document.mimeType == 'application/pdf'
                    ? Icons.picture_as_pdf
                    : Icons.image_outlined,
              ),
              title: Text(document.title),
              subtitle: Text(document.mimeType),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
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