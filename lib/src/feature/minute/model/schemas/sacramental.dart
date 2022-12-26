import 'package:atas/src/feature/minute/minute.dart';
import 'package:multiple_result/multiple_result.dart';

class Sacramental extends SchemaInterface {
  @override
  final minuteName = 'reunião sacramental';

  @override
  final items = [
    SchemaItem.createdAt(order: 1),
    SchemaItem.createdBy(order: 2),
    SchemaItem.meetingDate(order: 5),
    SchemaItem.heading(heading: Heading.presiding, order: 10),
    SchemaItem.heading(heading: Heading.heading, order: 20),
    SchemaItem.acknowledgments(order: 30),
    SchemaItem.announcement(order: 40),
    SchemaItem.musicConductor(order: 41),
    SchemaItem.hym(hymn: Hymns.first, order: 43),
    SchemaItem.pray(pray: Prays.first, order: 44),
    SchemaItem.call(call: Calls.call, order: 55),
    SchemaItem.call(call: Calls.release, order: 56),
    SchemaItem.confirmation(order: 57),
    SchemaItem.namingChild(order: 58),
    SchemaItem.hym(hymn: Hymns.sacramental, order: 60),
    SchemaItem.speaker(speaker: Speaker.first, order: 70),
    SchemaItem.speaker(speaker: Speaker.second, order: 80),
    SchemaItem.hym(hymn: Hymns.intermediary, order: 90),
    SchemaItem.speaker(speaker: Speaker.last, order: 100),
    SchemaItem.pray(pray: Prays.last, order: 110),
  ];

  @override
  Result<bool, MinuteLabel> validate(List<MinuteItem> minuteItems) {
    for (var item in items) {
      if (item.obligatory) {
        final contains = minuteItems.indexWhere((element) => element.label == item.label) != -1;
        if (!contains) return Error(item.label);
      }
    }
    return const Success(true);
  }
}
