import 'package:intl/intl.dart';

String transformDate(String jobDate) {
  final now = DateTime.now();
  String? dateString = jobDate;
  DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  DateTime date = dateFormat.parse(dateString);

  final difference = now.difference(date);
  final days = difference.inDays;

  if (days < 1) {
    return 'πριν από λίγο';
  }
  if (days == 1) {
    return 'πριν από 1 μέρα';
  }
  if (days < 7) {
    return 'πριν από $days μέρες';
  }
  if ((days ~/ 7) == 1) {
    return 'πριν από ${(days ~/ 7)} εβδομάδα';
  }
  if ((days ~/ 7) < 5) {
    return 'πριν από ${(days ~/ 7)} εβδομάδες';
  }
  if ((days ~/ 30) == 1) {
    return 'πριν από ${(days ~/ 30)} μήνα';
  }
  if ((days ~/ 30) < 12) {
    return 'πριν από ${(days ~/ 30)} μήνες';
  }
  if (((days ~/ 30) ~/ 12) == 1) {
    return 'πριν από 1 χρόνο';
  }

  return 'πριν από ${((days ~/ 30) / 12).toInt()} χρόνια';
}
