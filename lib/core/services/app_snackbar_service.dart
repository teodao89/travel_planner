import 'package:flutter/material.dart';

class AppSnackbarService {
  AppSnackbarService._();

  static void showSuccess(
      BuildContext context,
      String message, {
        String? actionLabel,
        VoidCallback? onAction,
        Duration duration = const Duration(seconds: 3),
      }) {
    _show(
      context,
      message,
      backgroundColor: Colors.green.shade700,
      actionLabel: actionLabel,
      onAction: onAction,
      duration: duration,
    );
  }

  static void showError(
      BuildContext context,
      String message, {
        Duration duration = const Duration(seconds: 3),
      }) {
    _show(
      context,
      message,
      backgroundColor: Colors.red.shade700,
      duration: duration,
    );
  }

  static void showInfo(
      BuildContext context,
      String message, {
        Duration duration = const Duration(seconds: 3),
      }) {
    _show(
      context,
      message,
      backgroundColor: Colors.blue.shade700,
      duration: duration,
    );
  }

  static void _show(
      BuildContext context,
      String message, {
        required Color backgroundColor,
        String? actionLabel,
        VoidCallback? onAction,
        required Duration duration,
      }) {
    final messenger = ScaffoldMessenger.of(context);

    messenger.clearSnackBars();

    messenger.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        duration: duration,
        action: actionLabel != null && onAction != null
            ? SnackBarAction(
          label: actionLabel,
          onPressed: onAction,
        )
            : null,
      ),
    );
  }
}