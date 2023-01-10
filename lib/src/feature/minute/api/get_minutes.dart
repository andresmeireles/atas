import 'package:atas/src/core/firebase/minutes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multiple_result/multiple_result.dart';

class GetMinutes {
  final _api = Minutes();

  Future<Result<List<Object?>, String>> get minutes async {
    final minutes = await _api.allDocuments('sacramental');

    return minutes.when((success) => Success(_organizeMinutes(success)), (error) => Error(error));
  }

  List<Object?> _organizeMinutes(DocumentReference response) {
    return [];
  }
}
