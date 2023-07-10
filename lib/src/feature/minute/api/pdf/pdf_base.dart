// import 'package:atas/src/feature/minute/minute.dart';
// import 'package:flutter_translate/flutter_translate.dart';
// import 'package:pdf/widgets.dart';

// mixin PdfBase {
//   Widget pdf(Context context);

//   leadingText(String text) {
//     return Text(text, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15));
//   }

//   Widget callRow({required Minutes minute, required Label label, String? placeholderText, int size = 30}) {
//     final call = getSingleCall(minute, label);
//     if (call == null) return Text(placeholderText ?? 'preencher');
//     final textArea = translate(call.label.value);
//     return listTile(
//       leading: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [Text('$textArea:'.padRight(size - textArea.length))],
//       ),
//       title: call.name,
//       subtitle: call.call,
//     );
//   }

//   Widget simpleRow({required Minutes minute, required Label label, String? placeholderText, int size = 30}) {
//     final simple = getSingleSimple(minute, label);
//     if (simple == null) return Text(placeholderText ?? 'preencher');
//     final text = translate(simple.label.value);
//     return listTile(
//       leading: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [Text('$text:'.padRight(size - text.length))],
//       ),
//       title: simple.value,
//     );
//   }

//   hymnRow({required Minutes minute, required Label label, String? placeholderText, int size = 30}) {
//     final hymn = getSingleHymn(minute, label);
//     if (hymn == null) return Text(placeholderText ?? 'preencher');
//     final text = translate(hymn.label.value);
//     return listTile(
//       leading: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [Text('$text:'.padRight(size - text.length))],
//       ),
//       title: hymn.name,
//       trailing: Text('Nº ${hymn.number}'),
//     );
//   }

//   List<Widget> multipleRow({required Minutes minute, required String name, required Label label, required Types type}) {
//     return [
//       leadingText(name),
//       SizedBox(height: 10),
//       SizedBox(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: getMultiples(minute, label, type).map((e) {
//             if (e.type == Types.call) {
//               final c = e as Call;
//               return Column(
//                 children: [
//                   Row(
//                     children: [
//                       Text(c.name.padRight(35 - c.name.length)),
//                       Text(c.call),
//                     ],
//                   ),
//                   SizedBox(height: 8),
//                 ],
//               );
//             }
//             final s = e as SimpleText;
//             return Text(s.value, style: const TextStyle(fontSize: 16));
//           }).toList(),
//         ),
//       ),
//       Divider(thickness: 2),
//     ];
//   }

//   List<Assign> getMultiples(Minutes minute, Label label, Types type) {
//     return minute.assignments.where((e) => e.label == label && e.type == type).toList();
//   }

//   Assign? getSingle(Minutes minute, Label label, Types type) {
//     final results = minute.assignments.where((e) => e.label == label && e.type == type);
//     if (results.isEmpty) return null;
//     return results.first;
//   }

//   Widget listTile({required String title, Widget? leading, String? subtitle, Widget? trailing}) {
//     return Row(
//       children: [
//         leading ?? SizedBox(),
//         SizedBox(width: 10.0),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text(title, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
//             Text(subtitle ?? '', style: const TextStyle(fontSize: 14.0)),
//           ],
//         ),
//         SizedBox(width: 10.0),
//         trailing ?? SizedBox(),
//       ],
//     );
//   }

//   Call? getSingleCall(Minutes minute, Label label) => getSingle(minute, label, Types.call) as Call?;

//   Hymn? getSingleHymn(Minutes minute, Label label) => getSingle(minute, label, Types.hymn) as Hymn?;

//   SimpleText? getSingleSimple(Minutes minute, Label label) => getSingle(minute, label, Types.simpleText) as SimpleText?;
// }
