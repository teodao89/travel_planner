import 'package:flutter/material.dart';

class AppDialogService {
  AppDialogService._();

  static Future<bool> confirm(
      BuildContext context, {
        required String title,
        required String message,
        String confirmText = 'Conferma',
        String cancelText = 'Annulla',
        IconData icon = Icons.help_outline,
        Color color = Colors.red,
      }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) {
        return AlertDialog(
          icon: Icon(icon, color: color),
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(cancelText),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(confirmText),
            ),
          ],
        );
      },
    );

    return result ?? false;
  }

  static Future<void> info(
      BuildContext context, {
        required String title,
        required String message,
        String buttonText = 'OK',
        IconData icon = Icons.info_outline,
        Color color = Colors.blue,
      }) async {
    await showDialog<void>(
      context: context,
      builder: (_) {
        return AlertDialog(
          icon: Icon(icon, color: color),
          title: Text(title),
          content: Text(message),
          actions: [
            FilledButton(
              onPressed: () => Navigator.pop(context),
              child: Text(buttonText),
            ),
          ],
        );
      },
    );
  }
}