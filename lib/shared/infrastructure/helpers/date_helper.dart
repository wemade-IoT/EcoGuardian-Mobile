String formatDate(DateTime dateTime) {
  String day = '${dateTime.day}';
  String month = _getMonthName(dateTime.month);
  String year = '${dateTime.year}';
  String hour = dateTime.hour.toString().padLeft(2, '0');
  String minute = dateTime.minute.toString().padLeft(2, '0');
  return '$day of $month, $year, $hour:$minute';
}

String _getMonthName(int month) {
  const months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];
  return months[month - 1];
}