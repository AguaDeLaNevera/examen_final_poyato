import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;
  static String _correu = '';
  static bool _isSaved = false;
  static String _password = '';

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String get correu {
    return _prefs.getString('correu') ?? _correu;
  }

  static bool get isSaved {
    return _prefs.getBool('saved') ?? _isSaved;
  }

  static String get password {
    return _prefs.getString('password') ?? _password;
  }

  static set correu(String value) {
    _correu = value;
    _prefs.setString('correu', value);
  }

  static set isSaved(bool value) {
    _isSaved = value;
    _prefs.setBool('saved', value);
  }

  static set password(String value) {
    _password = value;
    _prefs.setString('password', value);
  }
}
