import 'package:atas/src/core/core.dart';
import 'package:atas/src/feature/minute/api/export_pdf.dart';
import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';

class MinuteDashboard extends StatefulWidget {
  final GetMinute api;
  final ExportPdf pdf;

  const MinuteDashboard({required this.api, required this.pdf, super.key});

  @override
  State<MinuteDashboard> createState() => _MinuteDashboardState();
}

class _MinuteDashboardState extends State<MinuteDashboard> {
  List<Minutes> _minutes = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _setUp();
  }

  void _setUp() {
    widget.api.all.then(
      (value) => {
        value.when(
          (success) {
            setState(
              () {
                _loading = false;
                _minutes = success;
              },
            );
          },
          (error) {
            Fluttertoast.showToast(msg: error.message);
          },
        )
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(AddMinuteController.path);
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(title: const Text('lista de atas')),
      body: _loading ? _loader() : _minuteTiles(context),
    );
  }

  Widget _loader() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _minuteTiles(BuildContext context) {
    return ListView(
      children: _minutes
          .map(
            (e) => ListTile(
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(translate(e.status.value).toUpperCase()),
                ],
              ),
              title: Text(e.schema.value),
              subtitle: Text(DateFormat('dd/MM/y').format(e.date)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => context.push('${MinuteListController.path}/${e.id}'),
                    icon: const Icon(Icons.remove_red_eye),
                  ),
                  IconButton(
                      onPressed: () async {
                        final pdfFile = await widget.pdf.makePdf(e);
                        Printing.sharePdf(bytes: pdfFile, filename: 'document.pdf');
                      },
                      icon: const Icon(Icons.inventory_outlined)),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () async {
                      context.push('${EditMinuteController.path}/${e.id}').whenComplete(() => _setUp());
                    },
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
