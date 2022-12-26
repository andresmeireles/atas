import 'package:atas/src/core/database/shared_preferences/shared_preferences.dart';

class User extends AppSp {
  final _userKey = 'user';

  Future<String> addUser(String name) async {
    final sp = await sharedPreferences;
    await sp.setString(_userKey, name);
    return name;
  }

  Future<String?> getUser() async {
    final sp = await sharedPreferences;
    return sp.getString(_userKey);
  }

  Future<void> removeUser() async {
    final sp = await sharedPreferences;
    sp.remove(_userKey);
  }
}
