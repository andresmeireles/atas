import 'package:flutter/foundation.dart';

class Environment {
  static bool get isDevMode => !kReleaseMode;
}
