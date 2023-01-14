import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class CreatedMinuteList extends StatelessWidget {
  final List<MinuteList> minutes;

  const CreatedMinuteList(this.minutes, {super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: minutes.map((e) => _tile(context, minute: e, size: size * 0.09)).toList(),
      ),
    );
  }

  Widget _tile(BuildContext context, {required MinuteList minute, required double size}) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).pushNamed('edit_minute', params: {'minute': minute.name});
      },
      child: ListTile(
        title: Text(_title(minute.name), style: TextStyle(fontSize: size)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_date(minute.name), style: TextStyle(fontSize: size / 2)),
            Text(minute.status.statusName, style: TextStyle(fontSize: size / 2)),
          ],
        ),
      ),
    );
  }

  String _title(String name) {
    final type = name.substring(0, name.indexOf('-'));
    final enumType = MinuteTypes.values.firstWhere((element) => element.toString() == type);
    return enumType.name;
  }

  String _date(String name) {
    final date = name.substring(name.indexOf('-') + 1);
    final dateTime = DateFormat('dd-MM-yyyy').parse(date);
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }
}
