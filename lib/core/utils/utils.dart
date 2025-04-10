import 'package:intl/intl.dart';

String formatDate(String dateString) {
  final date = DateTime.parse(dateString);
  final formatter = DateFormat('MMMM d, yyyy');
  return formatter.format(date);
}
