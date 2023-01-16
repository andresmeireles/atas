import 'package:atas/src/feature/minute/minute.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class SchemaInterface {
  String get minuteName;

  /// Validate given items of minute
  bool validate(List<MinuteItem> minuteItems);

  /// check what items must be on minute to be valid
  Result<bool, List<MinuteLabel>> missing(List<MinuteItem> minuteItems);

  /// Parameters, obligatory or not, that minute must have to be valid
  List<SchemaItem> get items;

  List<SchemaItem> order() {
    items.sort((a, b) => a.order.compareTo(b.order));
    return items;
  }
}
