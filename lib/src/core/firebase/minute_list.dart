import 'package:atas/src/core/core.dart';
import 'package:atas/src/feature/minute/model/minute_list.dart' as app_minute_list;
import 'package:multiple_result/multiple_result.dart';

class MinuteList extends Core {
  Future<Result<String, String>> add(app_minute_list.MinuteList minute) async {
    try {
      final collection = db.collection('minute_list');
      final addedMinute = await collection.add(minute.toMap());
      return Success(addedMinute.id);
    } catch (e) {
      return Error(e.toString());
    }
  }

  Future<Result<List<app_minute_list.MinuteListAggregator>, String>> get minutes async {
    try {
      final collection = db.collection('minute_list');
      final minutes = await collection.get();
      final minuteNames = minutes.docs
          .map(
            (e) => app_minute_list.MinuteListAggregator(id: e.id, minute: app_minute_list.MinuteList.fromMap(e.data())),
          )
          .toList();
      return Success(minuteNames);
    } catch (e) {
      return Error(e.toString());
    }
  }

  Future<Result<app_minute_list.MinuteList, String>> minuteById(String id) async {
    try {
      final collection = db.collection('minute_list');
      final minutes = await collection.doc(id).get();
      final item = app_minute_list.MinuteList.fromMap(minutes.data()!);
      return Success(item);
    } catch (e) {
      return Error(e.toString());
    }
  }
}
