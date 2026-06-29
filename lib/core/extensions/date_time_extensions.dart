import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String toItalianDate() {
    return DateFormat('dd/MM/yyyy').format(this);
  }

  String toItalianTime() {
    return DateFormat('HH:mm').format(this);
  }
}