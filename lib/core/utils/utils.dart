import 'package:intl/intl.dart';

String formatDate(String dateString) {
  final date = DateTime.parse(dateString); // "2025-03-31"
  final formatter = DateFormat('MMMM d, yyyy'); // March 31, 2025
  return formatter.format(date);
}
