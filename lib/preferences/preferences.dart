import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences
      _prefs; // SharedPreferences instance to interact with device preferences
  static String _correu = ''; // Default value for 'correu' (email)
  static bool _isSaved =
      false; // Default value for 'isSaved' (a flag indicating if data is saved)
  static String _password = ''; // Default value for 'password'

  // Initialize SharedPreferences
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Getter for 'correu'
  static String get correu {
    return _prefs.getString('correu') ??
        _correu; // Retrieve 'correu' from SharedPreferences, use default if null
  }

  // Getter for 'isSaved'
  static bool get isSaved {
    return _prefs.getBool('saved') ??
        _isSaved; // Retrieve 'isSaved' from SharedPreferences, use default if null
  }

  // Getter for 'password'
  static String get password {
    return _prefs.getString('password') ??
        _password; // Retrieve 'password' from SharedPreferences, use default if null
  }

  // Setter for 'correu'
  static set correu(String value) {
    _correu = value;
    _prefs.setString('correu', value); // Save 'correu' to SharedPreferences
  }

  // Setter for 'isSaved'
  static set isSaved(bool value) {
    _isSaved = value;
    _prefs.setBool('saved', value); // Save 'isSaved' to SharedPreferences
  }

  // Setter for 'password'
  static set password(String value) {
    _password = value;
    _prefs.setString('password', value); // Save 'password' to SharedPreferences
  }
}
