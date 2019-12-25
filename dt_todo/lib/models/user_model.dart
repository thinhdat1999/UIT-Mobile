class UserModel {
  String uid;
  String username;
  String avatar;


  static final UserModel _instance = UserModel._internal();
  UserModel._internal();

  factory UserModel() {
    return _instance;
  }

  UserModel.fromMap(Map snapshot, String uid) {
    _instance.uid = uid;
    _instance.username = snapshot['username'];
    _instance.avatar = snapshot['avatar'];
  }
  toJson() {
    return {
      "username": username,
      "avatar": avatar,
    };
  }
}