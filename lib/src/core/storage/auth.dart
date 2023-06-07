import 'package:shared_preferences/shared_preferences.dart';

final _sp = SharedPreferences.getInstance();

const tokenName = 'token';

Future<void> setToken(String token) async {
  final sp = await _sp;
  await sp.setString(tokenName, token);
}

Future<String?> getToken() async {
  final sp = await _sp;
  return sp.getString(tokenName);
}
