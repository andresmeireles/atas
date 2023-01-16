import 'package:atas/src/core/firebase/firebase.dart';
import 'package:atas/src/feature/minute/minute.dart' as app_minute_list;
import 'package:multiple_result/multiple_result.dart';

class GetMinute {
  final _api = MinuteList();

  Future<Result<List<app_minute_list.MinuteListAggregator>, String>> get minutes async {
    final minutes = await _api.minutes;
    return minutes.when((success) => Success(success), (error) => Error(error));
  }
}
