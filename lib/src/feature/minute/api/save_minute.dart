// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:atas/src/core/firebase/minute_list.dart' as minute_list;
import 'package:atas/src/core/firebase/minutes.dart';

import '../minute.dart';

class SaveMinute {
  final List<MinuteItem> items;
  final SchemaInterface schema;
  final firebase = Minutes();
  final firebaseMinuteList = minute_list.MinuteList();

  SaveMinute({required this.items, required this.schema});

  Future<String> submit(String submitter) async {
    final validate = schema.validate(items);
    return validate.when(
      (success) async {
        final minuteName = await firebase.add(minuteItems: items, type: MinuteTypes.sacramental, editedBy: submitter);
        final minuteList = MinuteList(name: minuteName, status: MinuteListStatus.closed);
        await firebaseMinuteList.add(minuteList);
        return 'sucesso';
      },
      (error) => '${LocalizeLabel().label(error)} não encontrado',
    );
  }
}
