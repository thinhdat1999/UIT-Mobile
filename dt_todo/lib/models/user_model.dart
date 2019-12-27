import 'package:dt_todo/models/category_model.dart';

class UserModel {
  String uid;
  String username;


  static final UserModel _instance = UserModel._internal();
  UserModel._internal();

  factory UserModel() {
    return _instance;
  }

  UserModel.fromMap(Map snapshot, String uid) {
    _instance.uid = uid;
    _instance.username = snapshot['username'];
  }
  toJson() {
    return {
      "username": username,
    };
  }
}