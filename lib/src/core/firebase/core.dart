import 'package:atas/environment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multiple_result/multiple_result.dart';

class Core {
  /// instance of firestore database manager
  DocumentReference get db {
    final db = FirebaseFirestore.instance;
    if (Environment.isDevMode) {
      return db.collection('test').doc('minute');
    }
    return db.collection('prod').doc('minute');
  }

  Future<Result<DocumentReference<Object?>, String>> save(String document, Map<String, dynamic> map) async {
    try {
      final doc = await db.collection('minute').doc('sacramental').collection(document).add(map);
      return Success(doc);
    } catch (e) {
      return Error(e.toString());
    }
  }

  CollectionReference<Map<String, dynamic>> get security => db.firestore.collection('security');
}
