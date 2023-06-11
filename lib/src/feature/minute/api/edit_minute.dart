import 'package:atas/src/core/core.dart';
import 'package:atas/src/feature/minute/minute.dart';
import 'package:multiple_result/src/result.dart';

final class EditMinute with AppHttpCore implements MinuteSubmit {
  @override
  Future<Result<Minutes, FailResponse>> submit(Minutes minute) async {
    final request = putRequest('v1/minutes/${minute.id}', minute);
    final response = await request;
    return response.when((success) => Success(Minutes.fromJson(success)), (error) => Error(error));
  }
}
