import 'package:atas/src/core/core.dart';
import 'package:atas/src/feature/minute/model/minutes.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class MinuteSubmit {
  Future<Result<Minutes, FailResponse>> submit(Minutes minute);
}
