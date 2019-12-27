import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dt_todo/helper/DBHelper.dart';
import 'package:dt_todo/models/category_model.dart';
import 'package:dt_todo/models/note_model.dart';
import 'package:dt_todo/models/user_model.dart';
import 'package:flutter/cupertino.dart';

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

  Future getNumOfNotes(String categoryID) async {
    final response = await doc.ref.where('category', isEqualTo: categoryID).where('isDone', isEqualTo: false).getDocuments();
    return response.documents.length;
  }

  Future getNumOfMyDayNotes(String username) async {
    final response = await doc.ref.where('username', isEqualTo: username).where('isMyDay', isEqualTo: true).where('isDone', isEqualTo: false).orderBy('createDate', descending: true).getDocuments();
    return response.documents.length;
  }

  Future getNumOfImportanceNotes(String username) async {
    final response = await doc.ref.where('username', isEqualTo: username).where('isImportance', isEqualTo: true).where('isDone', isEqualTo: false).orderBy('createDate', descending: true).getDocuments();
    return response.documents.length;
  }

  Future getNumOfPlannedNotes(String username) async {
    final response = await doc.ref.where('username', isEqualTo: username).orderBy('dueDate').orderBy('createDate', descending: true).where('isDone', isEqualTo: false).getDocuments();
    return response.documents.length;
  }

  Stream<QuerySnapshot> fetchMyDayNotesAsStream(String username) {
    return doc.ref.where('username', isEqualTo: username).where('isMyDay', isEqualTo: true).orderBy('createDate', descending: true).snapshots();
  }

  Stream<QuerySnapshot> fetchNotesAsStream(String categoryID) {
    return doc.ref.where('category', isEqualTo: categoryID).orderBy('createDate', descending: true).snapshots();
  }

  Stream<QuerySnapshot> fetchImportanceNotesAsStream(String username) {
    return doc.ref.where('username', isEqualTo: username).where('isImportance', isEqualTo: true).orderBy('createDate', descending: true).snapshots();
  }

  Stream<QuerySnapshot> fetchPlannedNotesAsStream(String username) {
    return doc.ref.where('username', isEqualTo: username).orderBy('dueDate').orderBy('createDate', descending: true).snapshots();
  }

  Future insertNote(NoteModel note) async {
    await doc.ref.add(note.toJson());
    //Firestore.instance.collection('categories').document(note.category.id).updateData({"numOfNotes": FieldValue.increment(1)});
  }

  Future deleteNote(String id) async {
    await doc.ref.document(id).delete();
  }

  Future updateNote(NoteModel note) async =>
      await doc.ref.document(note.id).updateData(note.toJson());
}