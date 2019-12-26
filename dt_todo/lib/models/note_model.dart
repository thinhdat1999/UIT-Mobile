import 'package:dt_todo/blocs/category_blocs.dart';
import 'package:dt_todo/models/category_model.dart';
import 'package:dt_todo/models/user_model.dart';

class NoteModel {
  String id;
  CategoryModel category;
  String title;
  String description;
  bool isDone;
  bool isImportance;
  DateTime createDate;
  DateTime dueDate;
  UserModel user;

  NoteModel({this.category, this.title, this.description, this.isDone, this.isImportance, this.createDate, this.dueDate, this.user});

  NoteModel.fromMap(Map snapshot, String id) {
    this.id = id;
    CategoryBloc().getCategoryByID(snapshot['category']).then((value) {
      this.category = value;
    });
    this.title = snapshot['title'];
    this.description = snapshot['description'];
    this.isDone = snapshot['isDone'];
    this.isImportance = snapshot['isImportance'];
    this.createDate = DateTime.fromMillisecondsSinceEpoch(snapshot['createDate'].seconds * 1000);
    snapshot['dueDate'] != null ? this.dueDate = DateTime.fromMillisecondsSinceEpoch(snapshot['dueDate'].seconds * 1000) : this.dueDate = null;
  }

  toJson() {
    return {
      'title': title,
      'description': description ?? '',
      'isDone': isDone,
      'isImportance': isImportance,
      'createDate': createDate,
      if(dueDate != null) 'dueDate': dueDate,
      'category': category.id,
      'username': UserModel().username,
    };
  }
}