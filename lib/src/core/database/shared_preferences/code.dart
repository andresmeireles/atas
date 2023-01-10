import 'package:atas/src/core/database/shared_preferences/shared_preferences.dart';

class Code extends AppSp {
  final _codeKey = 'code';

  Future<int> addCode(int code) async {
    final sp = await sharedPreferences;
    await sp.setInt(_codeKey, code);
    return code;
  }

  Future<int?> getCode() async {
    final sp = await sharedPreferences;
    return sp.getInt(_codeKey);
  }

  Future<void> removeCode() async {
    final sp = await sharedPreferences;
    sp.remove(_codeKey);
  }
}
