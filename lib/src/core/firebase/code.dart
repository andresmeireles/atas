import 'dart:developer';

import 'package:atas/src/core/core.dart';
import 'package:multiple_result/multiple_result.dart';

class Code extends Core {
  Future<Result<int, String>> get securityCode async {
    try {
      final collection = await security.doc('key').get();
      if (collection.exists) {
        return Success(collection.data()!['code']);
      }
      return const Error('no code');
    } catch (e) {
      log(e.toString());
      return const Error('error when catch code');
    }
  }
}
