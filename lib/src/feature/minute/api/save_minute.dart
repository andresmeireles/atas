// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:atas/src/core/firebase/minutes.dart';

import '../minute.dart';

class SaveMinute {
  final List<MinuteItem> items;
  final SchemaInterface schema;

  SaveMinute({required this.items, required this.schema});

  Future<String> submit(String submitter) async {
    final firebase = Minutes();
    final validate = schema.validate(items);
    return validate.when(
      (success) async {
        await firebase.add(minuteItems: items, type: MinuteTypes.sacramental, editedBy: submitter);
        return 'sucesso';
      },
      (error) => '${LocalizeLabel().label(error)} não encontrado',
    );
  }
}
