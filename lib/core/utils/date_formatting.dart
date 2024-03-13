import 'package:intl/intl.dart';

String formatDatebydMMMYYYY(DateTime dateTime) {
  return DateFormat('d MMM,yyyy').format(dateTime);
}
