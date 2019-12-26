import 'package:cloud_firestore/cloud_firestore.dart';

class DBHelper{
  final Firestore db = Firestore.instance;
  CollectionReference ref;

  DBHelper(String path) {
    ref = db.collection(path);
  }


}