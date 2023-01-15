import 'package:atas/src/core/core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../feature/minute/minute.dart';

class Minutes extends Core {
  Future<String> add({
    required List<MinuteItem> minuteItems,
    required MinuteTypes type,
    required String editedBy,
  }) async {
    final updatedBy = SimpleText(value: editedBy, label: MinuteLabel.updatedBy, type: MinuteItemType.text);
    minuteItems.add(updatedBy);
    final minuteCollection = db.collection('minutes').doc('sacramental');
    final createdAt = minuteItems.firstWhere((element) => element.label == MinuteLabel.meetingDate) as SimpleText;
    final meetingDate = DateFormat('dd-MM-yyyy').format(DateTime.parse(createdAt.value));
    final minuteName = '${type.toString()}-$meetingDate';
    final minute = minuteCollection.collection(minuteName);
    final hasContent = (await minute.limit(1).get()).docs.isNotEmpty;
    if (hasContent) {
      return update(minuteName: minuteName, minuteItems: minuteItems, type: type, editedBy: editedBy);
    }
    for (var item in minuteItems) {
      await minute.doc('${item.label}-${item.id}').set(item.toMap());
    }
    return minuteName;
  }

  Future<String> update({
    required String minuteName,
    required List<MinuteItem> minuteItems,
    required MinuteTypes type,
    required String editedBy,
  }) async {
    final toRemove = [];
    final minutesToUpdate = minuteItems;
    final updatedBy = SimpleText(value: editedBy, label: MinuteLabel.updatedBy, type: MinuteItemType.text);
    final minutes = db.collection('minutes').doc('sacramental');
    final minute = minutes.collection(minuteName);
    final hasContent = (await minute.limit(1).get()).docs.isNotEmpty;
    if (!hasContent) {
      throw 'ata não existe';
    }
    final items = await minute.get();
    final firebaseMinuteItems = items.docs.map<MinuteItem>(_minuteMatcher).toList();
    for (var firebaseItem in firebaseMinuteItems) {
      int itemIndex = minuteItems.indexWhere((element) => element.label == firebaseItem.label);
      if (firebaseItem.type == MinuteItemType.announcement) {
        itemIndex = minuteItems.indexWhere(
          (element) => (element as Announcement).title == (firebaseItem as Announcement).title,
        );
      }
      if (firebaseItem.type == MinuteItemType.acknowledgment) {
        itemIndex = minuteItems.indexWhere(
          (element) => (element as Acknowledgment).name == (firebaseItem as Acknowledgment).name,
        );
      }
      if (itemIndex == -1) {
        toRemove.add(firebaseItem);
      }
    }
    return minuteName;
  }

  Future<List<MinuteItem>> byName(String name) async {
    final minute = await db.collection('minutes').doc('sacramental').collection(name).get();
    final items = minute.docs.map((e) => _minuteMatcher(e)).toList();
    return items;
  }

  MinuteItem _minuteMatcher(QueryDocumentSnapshot snapshot) {
    final map = snapshot.data() as Map<String, dynamic>;
    return TypeResolver.resolve(map['type'], map);
  }
}
