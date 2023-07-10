

// final class ExportPdf {
//   Future<Uint8List> makePdf(Minutes minute) async {
//     switch (minute.schema) {
//       case Schema.sacramental:
//         return _makePdfFromMinute(minute);
//     }
//   }

  // Future<Uint8List> _makePdfFromMinute(Minutes minute) async {
  //   final maker = _getMaker(minute);
  //   final pdf = Document();
  //   pdf.addPage(Page(build: maker.pdf, pageFormat: PdfPageFormat.a4));
  //   return pdf.save();
  // }

  // PdfBase _getMaker(Minutes minutes) {
  //   final schema = minutes.schema;
  //   switch (schema) {
  //     case Schema.sacramental:
  //       return SacramentalPdf(minute: minutes);
  //   }
  // }
// }
