String getCurrentDateTime() {
  // Get the current date and time
  DateTime now = DateTime.now();

  // Format the date and time as a string
  String formattedDateTime = "${now.year}-${_twoDigits(now.month)}-${_twoDigits(now.day)} ${_twoDigits(now.hour)}:${_twoDigits(now.minute)}:${_twoDigits(now.second)}";

  return formattedDateTime;
}

String _twoDigits(int n) {
  // Helper method to add leading zeros if needed
  if (n >= 10) {
    return "$n";
  } else {
    return "0$n";
  }
}