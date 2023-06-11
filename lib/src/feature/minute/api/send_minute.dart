import 'package:atas/src/core/core.dart';
import 'package:atas/src/feature/minute/minute.dart';
import 'package:multiple_result/multiple_result.dart';

final class SendMinute with AppHttpCore implements MinuteSubmit {
  @override
  Future<Result<Minutes, FailResponse>> submit(Minutes submit) async {
    final request = postRequest('v1/minutes', submit);
    final response = await request;
    return response.when(
      (success) => Success(Minutes.fromJson(success)),
      (error) => Error(error),
    );
  }
}
