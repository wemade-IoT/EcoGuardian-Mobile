bool _isValidEmail(String email) {
  final emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  return emailRegex.hasMatch(email);
}

bool _isValidPassword(String password) {
  final passwordRegex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d@$!%*?&]{8,}$',
  );
  return passwordRegex.hasMatch(password);
}

bool _isValidPhoneNumber(String phoneNumber) {
  final phoneRegex = RegExp(
    r'^\+?[1-9]\d{1,14}$',
  );
  return phoneRegex.hasMatch(phoneNumber);
}

bool _isValidUrl(String url) {
  final urlRegex = RegExp(
    r'^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$',
  );
  return urlRegex.hasMatch(url);
}