import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multiple_result/multiple_result.dart';

class Core {
  /// instance of firestore database manager
  final db = FirebaseFirestore.instance;

  Future<Result<DocumentReference<Object?>, String>> save(String document, Map<String, dynamic> map) async {
    try {
      final doc = await db.collection(document).add(map);
      return Success(doc);
    } catch (e) {
      return Error(e.toString());
    }
  }

  Future<Result<QuerySnapshot, String>> allDocuments(String document) async {
    try {
      final doc = db.collection(document);
      final all = await doc.get();
      return Success(all);
    } catch (e) {
      return Error(e.toString());
    }
  }
}
