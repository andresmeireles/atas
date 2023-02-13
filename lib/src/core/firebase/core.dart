import 'package:atas/environment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Core {
  /// instance of firestore database manager
  DocumentReference get db {
    final db = FirebaseFirestore.instance;
    if (Environment.isDevMode) {
      return db.collection('test').doc('minute');
    }
    return db.collection('prod').doc('minute');
  }

  CollectionReference<Map<String, dynamic>> get security => db.firestore.collection('security');
}
