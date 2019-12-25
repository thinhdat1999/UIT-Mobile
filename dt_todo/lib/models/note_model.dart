import 'package:dt_todo/models/category_model.dart';

class NoteModel {
  String id;
  CategoryModel category;
  String title;
  String description;
  bool isDone;
  bool isImportance;
  DateTime createDate;
  DateTime dueDate;

  NoteModel({this.category, this.title, this.description, this.isDone, this.isImportance, this.createDate, this.dueDate});

  NoteModel.fromMap(Map snapshot, String id) {
    this.id = id;
    this.title = snapshot['title'];
    this.description = snapshot['description'];
    this.isDone = snapshot['isDone'];
    this.isImportance = snapshot['isImportance'];
    this.createDate = DateTime.fromMillisecondsSinceEpoch(snapshot['createDate'].seconds * 1000);
    this.dueDate = DateTime.fromMillisecondsSinceEpoch(snapshot['dueDate'].seconds * 1000);
  }

  toJson() {
    return {
      'title': title,
      'description': description,
      'isDone': isDone,
      'isImportance': isImportance,
      'createDate': createDate,
      'dueDate': dueDate,
      'category': category.id,
    };
  }
}