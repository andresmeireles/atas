import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get envType => kReleaseMode ? '.env.prod' : '.env.dev';

  static bool get isDevMode => dotenv.env['DEV_MODE'] == 'true';
}
