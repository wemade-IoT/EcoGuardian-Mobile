import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {

  static const String _tokenKey = 'token';
  static const String _userKey = 'user';

  static bool isValidToken(String? token) {
    return token != null && token.isNotEmpty;
  }

  static bool isInvalidToken(String? token) {
    return !isValidToken(token);
  }

  // replace dynamic with a specific user entityyy
  static Future<void> saveUser (dynamic user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', user.toString());
  }

  // same as above boe
  static Future<dynamic> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('user');
    if (user != null) return user;
    return null;
  }

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<bool> hasToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_tokenKey);
  }

  static Future<void> removeCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userKey);
  }
}