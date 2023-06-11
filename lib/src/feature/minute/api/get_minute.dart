import 'dart:convert';

import 'package:atas/src/core/core.dart';
import 'package:atas/src/feature/minute/minute.dart';
import 'package:multiple_result/multiple_result.dart';

class GetMinute with AppHttpCore {
  Future<Result<List<Minutes>, FailResponse>> get all async {
    final request = getRequest('v1/minutes');
    final response = await request;
    return response.when(
      (success) {
        final minutes = jsonDecode(success) as List<dynamic>;
        return Success(minutes.map((e) => Minutes.fromJson((jsonEncode(e)))).toList());
      },
      (error) => Error(error),
    );
  }

  Future<Result<Minutes, FailResponse>> byId(int minuteId) async {
    final request = getRequest('v1/minutes/$minuteId');
    final response = await request;
    return response.when((success) => Success(Minutes.fromJson(success)), (error) => Error(error));
  }
}
