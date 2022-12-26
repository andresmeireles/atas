// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';

class MinuteTile extends StatelessWidget {
  final MinuteLabel label;
  final MinuteItemType type;
  final List<MinuteItem> items;
  final bool fixed;

  const MinuteTile({
    required this.label,
    required this.type,
    required this.items,
    required this.fixed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l = LocalizeLabel().label(label);
    if (type == MinuteItemType.acknowledgment && (label == MinuteLabel.presiding || label == MinuteLabel.heading)) {
      return HeadingPresidingTile(items.first as Acknowledgment);
    }
    switch (type) {
      case MinuteItemType.announcement:
        return AnnouncementsTile(items.map((e) => e as Announcement).toList());
      case MinuteItemType.call:
        return CallTile(label: l, calls: items.map((e) => e as Call).toList());
      case MinuteItemType.acknowledgment:
        return Column(
          children: [AcknowledgmentTile(items.map((e) => e as Acknowledgment).toList())],
        );
      case MinuteItemType.hymn:
        return HymnTile(hymn: items.first as Hymn, label: l);
      case MinuteItemType.testimony:
      case MinuteItemType.date:
      case MinuteItemType.text:
        return SimpleTextTile(items.first as SimpleText, fixed: fixed);
    }
  }
}
