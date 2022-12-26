// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:atas/src/feature/minute/minute.dart';

class SchemaItem {
  final MinuteLabel label;
  final MinuteItemType type;
  final int order;
  final bool obligatory;
  final bool repeatable;
  final bool fixed;

  SchemaItem({
    required this.label,
    required this.type,
    required this.order,
    this.obligatory = true,
    this.repeatable = false,
    this.fixed = false,
  });

  factory SchemaItem.announcement({order = 10}) {
    return SchemaItem(
      label: MinuteLabel.announcement,
      type: MinuteItemType.announcement,
      order: order,
      repeatable: true,
      obligatory: false,
    );
  }

  factory SchemaItem.heading({required Heading heading, order = 10}) {
    return SchemaItem(label: heading.label, type: MinuteItemType.acknowledgment, order: order);
  }

  factory SchemaItem.acknowledgments({order = 10}) {
    return SchemaItem(
      label: MinuteLabel.acknowledgment,
      type: MinuteItemType.acknowledgment,
      order: order,
      repeatable: true,
      obligatory: false,
    );
  }

  factory SchemaItem.call({required Calls call, order = 10}) =>
      SchemaItem(label: call.label, type: MinuteItemType.call, order: order, obligatory: false, repeatable: true);

  factory SchemaItem.hym({required Hymns hymn, order = 10}) =>
      SchemaItem(label: hymn.label, type: MinuteItemType.hymn, order: order);

  factory SchemaItem.pray({required Prays pray, order = 10}) =>
      SchemaItem(label: pray.label, type: MinuteItemType.text, order: order);

  factory SchemaItem.speaker({required Speaker speaker, order = 10}) =>
      SchemaItem(label: speaker.label, type: MinuteItemType.text, order: order);

  factory SchemaItem.confirmation({order = 10}) {
    return SchemaItem(
      label: MinuteLabel.confirmation,
      type: MinuteItemType.text,
      order: order,
      obligatory: false,
      repeatable: true,
    );
  }

  factory SchemaItem.createdBy({order = 10}) {
    return SchemaItem(label: MinuteLabel.createdBy, type: MinuteItemType.text, order: order, fixed: true);
  }

  factory SchemaItem.meetingDate({order = 10}) {
    return SchemaItem(label: MinuteLabel.meetingDate, type: MinuteItemType.date, order: order);
  }

  factory SchemaItem.createdAt({order = 10}) {
    return SchemaItem(label: MinuteLabel.createdAt, type: MinuteItemType.date, order: order, fixed: true);
  }

  factory SchemaItem.namingChild({order = 10}) {
    return SchemaItem(
      label: MinuteLabel.namingChild,
      type: MinuteItemType.text,
      order: order,
      obligatory: false,
      repeatable: true,
    );
  }

  factory SchemaItem.musicConductor({order = 10}) =>
      SchemaItem(label: MinuteLabel.musicConductor, type: MinuteItemType.text, order: order);
}
