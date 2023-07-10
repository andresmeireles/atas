// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:atas/src/feature/minute/minute.dart';
// import 'package:pdf/widgets.dart';

// class SacramentalPdf with PdfBase {
//   final Minutes minute;

//   SacramentalPdf({required this.minute});

//   @override
//   Widget pdf(Context context) {
//     return ListView(
//       children: [
//         SizedBox(height: 8),
//         callRow(minute: minute, label: Label.presiding),
//         callRow(minute: minute, label: Label.driving),
//         SizedBox(height: 20),
//         if (getMultiples(minute, Label.recognition, Types.call).isNotEmpty)
//           ...multipleRow(minute: minute, name: 'Reconhecimento', label: Label.recognition, type: Types.call),
//         if (getMultiples(minute, Label.announcement, Types.simpleText).isNotEmpty)
//           ...multipleRow(minute: minute, name: 'Anúncios', label: Label.announcement, type: Types.simpleText),
//         hymnRow(minute: minute, label: Label.firstHymn, placeholderText: 'primeiro hino'),
//         simpleRow(minute: minute, label: Label.fistPray, placeholderText: 'primeira oração'),
//         if (getMultiples(minute, Label.call, Types.call).isNotEmpty)
//           ...multipleRow(minute: minute, name: 'Chamados', label: Label.call, type: Types.call),
//         if (getMultiples(minute, Label.callRelease, Types.call).isNotEmpty)
//           ...multipleRow(minute: minute, name: 'Desobrigação', label: Label.callRelease, type: Types.call),
//         hymnRow(minute: minute, label: Label.sacramentalHym, placeholderText: 'hino sacramental'),
//         SizedBox(height: 20),
//         leadingText('Sacramento'),
//         SizedBox(height: 20),
//         simpleRow(minute: minute, label: Label.firstSpeaker, placeholderText: 'primeiro orador'),
//         simpleRow(minute: minute, label: Label.secondSpeaker),
//         hymnRow(minute: minute, label: Label.intermediaryHym, placeholderText: 'Hino Intermediário'),
//         simpleRow(minute: minute, label: Label.thirdSpeaker, placeholderText: 'ultimo orador'),
//         hymnRow(minute: minute, label: Label.endingHymn, placeholderText: 'hino de encerramento'),
//         simpleRow(minute: minute, label: Label.endingPray, placeholderText: 'oração de encerramento'),
//         SizedBox(height: 30),
//       ],
//     );
//   }
// }
