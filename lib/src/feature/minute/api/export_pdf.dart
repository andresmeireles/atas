import 'dart:typed_data';

import 'package:atas/src/feature/minute/minute.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

final class ExportPdf {
  Future<Uint8List> makePdf(Minutes minute) async {
    switch (minute.schema) {
      case Schema.sacramental:
        return _makeSacramentalMinute(minute);
    }
  }

  _makeSacramentalMinute(Minutes minute) {
    final pdf = pw.Document();
    final assignments = minute.assignments;
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text('Reunião Sacramental', textAlign: pw.TextAlign.center),
              pw.SizedBox(height: 20),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [pw.Text('Data: ${DateFormat('dd/MM/y').format(minute.date)}'), pw.Text('Frequência: ____')],
              ),
              pw.SizedBox(height: 20),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('Boas Vindas e Reconhecimentos'),
                  pw.Text('_' * 70),
                  pw.Text('_' * 70),
                  pw.Text('_' * 70),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [pw.Text('Presidido: Andre Meireles'), pw.Text('Dirigido: Andre Meireles')],
              ),
              pw.SizedBox(height: 20),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('Anúncios'),
                  pw.Text('_' * 70),
                  pw.Text('_' * 70),
                  pw.Text('_' * 70),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  _makeHymnRow(
                    label: 'Hino Inicial',
                    name: _geHymnName(assignments, Label.firstHymn),
                    number: _getHymnNumber(assignments, Label.firstHymn),
                    valueLength: 80,
                    labelLength: 90,
                  ),
                  pw.Text('Regente: Andre Meireles'),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Text('Oração Inicial: Yasmim Meireles', textAlign: pw.TextAlign.left),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('Desobrigações'),
                  pw.Text('_' * 70),
                  pw.Text('_' * 70),
                  pw.Text('_' * 70),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('Chamados'),
                  pw.Text('_' * 70),
                  pw.Text('_' * 70),
                  pw.Text('_' * 70),
                ],
              ),
              pw.SizedBox(height: 20),
              _makeHymnRow(
                label: 'Hino Sacramental',
                name: _geHymnName(assignments, Label.sacramentalHym),
                number: _getHymnNumber(assignments, Label.sacramentalHym),
              ),
              pw.SizedBox(height: 10),
              _makeRow(label: 'Primeiro Orador', value: 'Andre Meireles'),
              pw.SizedBox(height: 10),
              _makeRow(label: 'Segundo Orador', value: 'Andre Meireles'),
              pw.SizedBox(height: 10),
              _makeHymnRow(
                label: 'Hino Intermediário',
                name: _geHymnName(assignments, Label.intermediaryHym),
                number: _getHymnNumber(assignments, Label.intermediaryHym),
              ),
              pw.SizedBox(height: 10),
              _makeRow(label: 'Terceiro Orador', value: 'Andre Meireles'),
              pw.SizedBox(height: 10),
              _makeHymnRow(
                label: 'Hino de Encerramento',
                name: _geHymnName(assignments, Label.endingHymn),
                number: _getHymnNumber(assignments, Label.endingHymn),
              ),
              pw.SizedBox(height: 10),
              _makeRow(label: 'Ultima oração', value: 'Andre Meireles')
            ],
          );
        },
      ),
    );
    return pdf.save();
  }

  String _geHymnName(List<Assign> a, Label label) {
    final r = a.where((element) => element.label == label && element.type == Types.hymn);
    if (r.isEmpty) return '';
    return (r.first as Hymn).name;
  }

  int _getHymnNumber(List<Assign> a, Label label) {
    final r = a.where((element) => element.label == label && element.type == Types.hymn);
    if (r.isEmpty) return 0;
    return (r.first as Hymn).number;
  }

  String _getCallName(List<Assign> a, Label label) {
    final r = a.where((element) => element.label == label && element.type == Types.call);
    if (r.isEmpty) return '';
    return (r.first as Call).name;
  }

  String _getCall(List<Assign> a, Label label) {
    final r = a.where((element) => element.label == label && element.type == Types.call);
    if (r.isEmpty) return '';
    return (r.first as Call).call;
  }

  List<Call> _getMultipleCall(List<Assign> a, Label label) {
    final r = a.where((element) => element.label == label && element.type == Types.call);
    return r.map((e) => e as Call).toList();
  }

  pw.Row _makeRow({required String label, required String value, int labelLength = 140, int valueLength = 180}) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.start,
      children: [
        pw.SizedBox(width: labelLength.toDouble(), child: pw.Text('$label:')),
        pw.SizedBox(width: valueLength.toDouble(), child: pw.Text(value)),
      ],
    );
  }

  pw.Row _makeHymnRow({
    required String label,
    required String name,
    required int number,
    int labelLength = 140,
    int valueLength = 180,
  }) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.start,
      children: [
        pw.SizedBox(width: labelLength.toDouble(), child: pw.Text('$label:')),
        pw.SizedBox(width: valueLength.toDouble(), child: pw.Text(name)),
        pw.Text('Nº $number'),
      ],
    );
  }
}
