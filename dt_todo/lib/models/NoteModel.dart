class NoteModel {
  String title;
  String description;
  bool isDone;
  bool isImportance;
  DateTime createDate;
  DateTime dueDate;

  NoteModel({this.title, this.description, this.isDone, this.isImportance, this.createDate, this.dueDate});
}