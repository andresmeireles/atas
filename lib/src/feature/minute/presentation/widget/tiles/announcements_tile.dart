import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../minute.dart';

class AnnouncementsTile extends StatelessWidget {
  final List<Announcement> announcements;

  const AnnouncementsTile(this.announcements, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('anúncios'),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: announcements.map((a) => _tile(context, a)).toList()),
        ),
      ],
    );
  }

  Widget _tile(BuildContext context, Announcement announcement) {
    return ListTile(
      title: Text(announcement.title),
      subtitle: Column(
        children: [
          if (announcement.placement != null) _listItem('Local', announcement.placement!),
          if (announcement.dateTime != null) _listItem('Data', _formatDate(announcement.dateTime!)),
          if (announcement.dateTime != null) _listItem('Hora', _formatHour(announcement.dateTime!)),
          if (announcement.observation != null) _listItem('Observação', announcement.observation!),
        ],
      ),
      trailing: IconButton(
        onPressed: () {
          context.read<MinuteBloc>().add(RemoveItemEvent(announcement));
        },
        icon: const Icon(Icons.close),
      ),
    );
  }

  String _formatDate(DateTime date) => '${date.day}/${date.month}/${date.year}';

  String _formatHour(DateTime date) => DateFormat('hh:mm').format(date);

  Widget _listItem(String label, String content) => Row(children: [Text('$label:  '), Text(content)]);
}
