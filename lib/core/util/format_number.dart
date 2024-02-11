import 'package:intl/intl.dart';

String formatWithCommas(double number) {
  return number.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match match) => '${match[1]},',
      );
}

String formatDateString(String originalDateString) {
  // Parse the original date string
  DateTime originalDate = DateTime.parse(originalDateString);

  // Format the date as per your desired format (English) with locale 'en'
  DateFormat formatter = DateFormat("HH:mm dd-MM-yyyy", 'en');
  String formattedDate = formatter.format(originalDate);

  return formattedDate;
}
