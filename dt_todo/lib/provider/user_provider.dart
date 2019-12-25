
import 'dart:async';
import 'package:dt_todo/helper/DBHelper.dart';
import '../models/user_model.dart';

class UserProvider {

  final doc = DBHelper('users');

  Future getUserByUsername(String username) async {
    final response = await doc.ref.where('username', isEqualTo: username).limit(1).getDocuments();
    if (response.documents.isEmpty) return null;
    final json = response.documents.elementAt(0);
    return UserModel.fromMap(json.data, json.documentID);
  }

  Future updateUser(UserModel data) async {
    await doc.ref.document(data.uid).updateData(data.toJson());
  }

  Future insertUser(UserModel data) async {
    //await doc.ref.document(data.username).setData(data.toJson());
    await doc.ref.add(data.toJson());
  }
}