import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multiple_result/multiple_result.dart';

class Core {
  /// instance of firestore database manager
  final db = FirebaseFirestore.instance;

  Future<Result<DocumentReference<Object?>, String>> save(String document, Map<String, dynamic> map) async {
    try {
      final doc = await db.collection('minute').doc('sacramental').collection(document).add(map);
      return Success(doc);
    } catch (e) {
      return Error(e.toString());
    }
  }

  Future<Result<DocumentReference, String>> allDocuments(String document) async {
    try {
      final doc = db.collection('minutes').doc(document);
      final u = await doc.collection('MinuteTypes.sacramental-02-01-2023').get();
      for (var i in u.docs) {
        print(i.data());
      }
      return Success(doc);
    } catch (e) {
      return Error(e.toString());
    }
  }
}
