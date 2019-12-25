import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dt_todo/helper/DBHelper.dart';
import 'package:dt_todo/models/category_model.dart';
import 'package:dt_todo/models/note_model.dart';

class NoteProvider {

  final doc = DBHelper('notes');

  Future getNotesByCategory(String categoryID) async {
    var notes = [];
    final response =
    await doc.ref.where('category', isEqualTo: categoryID).getDocuments();
    response.documents.forEach(
            (doc) => notes.add(NoteModel.fromMap(doc.data, doc.documentID)));
    return notes;
  }


  Stream<QuerySnapshot> fetchNotesAsStream(String categoryID) {
    return doc.ref.where('category', isEqualTo: categoryID).snapshots();
  }


  Future insertNote(NoteModel note) async {
    await doc.ref.add(note.toJson());
  }
}