import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  // Use the exact key name requested: 'isUserLoged'
  static const String _keyIsUserLogged = 'isUserLoged';

  Future<bool> getIsUserLogged() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsUserLogged) ?? false;
  }

  Future<void> setIsUserLogged(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsUserLogged, value);
  }
}
