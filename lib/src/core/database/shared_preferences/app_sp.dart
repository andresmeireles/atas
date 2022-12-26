import 'package:shared_preferences/shared_preferences.dart';

abstract class AppSp {
  final sharedPreferences = SharedPreferences.getInstance();
}
