import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/widgets.dart';

class TypeResolver {
  static MinuteItem resolve(String type, Map jsonMap) {
    final itemType = MinuteItemType.values.firstWhere((e) => e.toString() == type);
    final map = jsonMap as Map<String, dynamic>;
    switch (itemType) {
      case MinuteItemType.announcement:
        return Announcement.fromMap(map);
      case MinuteItemType.acknowledgment:
        return Acknowledgment.fromMap(map);
      case MinuteItemType.call:
        return Call.fromMap(map);
      case MinuteItemType.hymn:
        return Hymn.fromMap(map);
      case MinuteItemType.testimony:
      case MinuteItemType.date:
      case MinuteItemType.text:
        return SimpleText.fromMap(map);
    }
  }

  static Widget resolveWidget(SchemaItem schemaItem) {
    switch (schemaItem.type) {
      case MinuteItemType.announcement:
        return AnnouncementForm(schemaItem);
      case MinuteItemType.hymn:
        return HymForm(schemaItem);
      case MinuteItemType.acknowledgment:
        return HeadingPresidingForm(schemaItem);
      case MinuteItemType.call:
        return CallForm(schemaItem);
      case MinuteItemType.date:
        return DatePickerForm(schemaItem);
      case MinuteItemType.testimony:
      case MinuteItemType.text:
        return TextForm(schemaItem);
    }
  }
}
