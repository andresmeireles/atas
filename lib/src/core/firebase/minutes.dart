import 'package:atas/src/core/core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../feature/minute/minute.dart';

class Minutes extends Core {
  /// return isntance of minute collection
  CollectionReference get minutesCollection => db.collection('minutes');

  Future<void> add({
    required String minuteName,
    required List<MinuteItem> minuteItems,
    required MinuteTypes type,
    required String editedBy,
  }) async {
    final updatedBy = SimpleText(value: editedBy, label: MinuteLabel.updatedBy, type: MinuteItemType.text);
    minuteItems.add(updatedBy);
    final minuteCollection = minutesCollection.doc('sacramental');
    final minute = minuteCollection.collection(minuteName);
    final hasContent = (await minute.limit(1).get()).docs.isNotEmpty;
    if (hasContent) {
      return update(minuteName: minuteName, minuteItems: minuteItems, type: type, editedBy: editedBy);
    }
    for (var item in minuteItems) {
      await minute.doc('${item.label}-${item.id}').set(item.toMap());
    }
  }

  Future<void> update({
    required String minuteName,
    required List<MinuteItem> minuteItems,
    required MinuteTypes type,
    required String editedBy,
  }) async {
    final updateTime = DateTime.now().millisecondsSinceEpoch.toString();
    final minutesToUpdate = minuteItems;
    final updatedBy = SimpleText(value: editedBy, label: MinuteLabel.updatedBy, type: MinuteItemType.text);
    final updatedAt = SimpleText(value: updateTime, label: MinuteLabel.updatedAt, type: MinuteItemType.text);
    minuteItems.removeWhere(
      (element) => element.label == MinuteLabel.updatedAt || element.label == MinuteLabel.updatedBy,
    );
    minutesToUpdate.addAll([updatedAt, updatedBy]);
    final minutes = minutesCollection.doc('sacramental');
    final minute = minutes.collection(minuteName);
    final minuteContent = await minute.get();

    /// delete items
    for (final item in minuteContent.docs) {
      item.reference.delete();
    }
    for (var item in minuteItems) {
      await minute.doc('${item.label}-${item.id}').set(item.toMap());
    }
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
