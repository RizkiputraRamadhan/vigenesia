import 'package:shared_preferences/shared_preferences.dart';

class Sessions {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String? getToken() {
    return _prefs.getString('access_token');
  }

  static String? getUsername() {
    return _prefs.getString('username');
  }

  static int? getUserId() {
    return _prefs.getInt('user_id');
  }


  static Future<void> clearAllSessions() async {
    await _prefs.clear();
  }
}
