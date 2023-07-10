part of 'form_handler.dart';

MinuteItem? _minuteItem(BuildContext context, String label, Types type) {
  final addedItems = context.read<MinuteBloc>().state.addedItems;
  if (addedItems.isEmpty) return null;
  try {
    return addedItems.firstWhere((i) => i.label == label && i.type == type);
  } catch (_) {
    return null;
  }
}

List<MinuteItem> _minuteItems(BuildContext context, String label, Types type) {
  final addedItems = context.read<MinuteBloc>().state.addedItems;
  if (addedItems.isEmpty) return [];
  return addedItems.where((i) => i.label == label && i.type == type).toList();
}

Widget _singleCallItem(BuildContext context, String label) {
  final item = _minuteItem(context, label, Types.call);
  if (item == null) return const SizedBox();

  return CallTileBloc(item: item as CallItem);
}

List<Widget> _multipleCallItem(BuildContext context, String label) {
  final items = _minuteItems(context, label, Types.call);
  return items.map((i) => CallTileBloc(item: i as CallItem)).toList();
}

Widget _singleHymnItem(BuildContext context, String label) {
  final item = _minuteItem(context, label, Types.hymn);
  if (item == null) return const SizedBox();
  return HymnTileBloc(item: item as HymnItem);
}

// List<Widget> _multipleHymnItem(BuildContext context, String label) {
//   final items = _minuteItems(context, label, Types.hymn);
//   return items.map((i) => HymnTileBloc(item: i as HymnItem)).toList();
// }

Widget _singleSimpleTextItem(BuildContext context, String label) {
  final item = _minuteItem(context, label, Types.simpleText);
  if (item == null) return const SizedBox();
  return SimpleTextTileBloc(item: item as SimpleTextItem);
}

List<Widget> _multipleSimpleTextItem(BuildContext context, String label) {
  final items = _minuteItems(context, label, Types.simpleText);
  return items.map((i) => SimpleTextTileBloc(item: i as SimpleTextItem)).toList();
}
