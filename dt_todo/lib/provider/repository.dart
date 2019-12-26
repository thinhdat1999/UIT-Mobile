import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dt_todo/helper/SmartList.dart';
import 'package:dt_todo/models/category_model.dart';
import 'package:dt_todo/models/note_model.dart';
import 'package:dt_todo/models/user_model.dart';
import 'package:dt_todo/provider/category_provider.dart';
import 'package:dt_todo/provider/note_provider.dart';
import 'package:dt_todo/provider/user_provider.dart';
import 'package:flutter/material.dart';

class Repository {
  final userProvider = UserProvider();
  final categoryProvider = CategoryProvider();
  final noteProvider = NoteProvider();

  Future getUserByUsername(String username) => userProvider.getUserByUsername(username);

  Future updateUser(UserModel data) => userProvider.updateUser(data);

  Future insertUser(UserModel data) async {
    userProvider.insertUser(data);

    SmartList.categorySmartList.forEach((category) => {
      categoryProvider.insertCategory(category),
      print(category.toString())
    });
  }

  Future getLastIndex(String username) => categoryProvider.getLastIndex(username);

  Future getCategoryByID(String id) => categoryProvider.getCategoryByID(id);

  Future fetchCategories(String username) => categoryProvider.fetchCategories(username);

  Stream fetchCategoriesAsStream(String username) => categoryProvider.fetchCategoriesAsStream(username);

  Future getCategoriesByUsername(String username) => categoryProvider.getCategoriesByUsername(username);

  Future getSmartCategoriesByUsername(String username) => categoryProvider.getSmartCategoriesByUsername(username);

  Future insertCategory(CategoryModel category) => categoryProvider.insertCategory(category);

  Future deleteCategory(String id) async {
    final db = Firestore.instance;
    WriteBatch batch = db.batch();
    List noteList = await getNotesByCategory(id);
    noteList.forEach((note) {
      DocumentReference ref = db.collection('notes').document(note.id);
      batch.delete(ref);
    });
    await batch.commit();
    categoryProvider.deleteCategory(id);
  }

  Future updateCategory(CategoryModel category) => categoryProvider.updateCategory(category);

  Future getNotesByCategory(String categoryID) => noteProvider.getNotesByCategory(categoryID);

  Stream fetchNotesAsStream(String categoryID) => noteProvider.fetchNotesAsStream(categoryID);

  Stream fetchImportanceNotesAsStream(String username) => noteProvider.fetchImportanceNotesAsStream(username);

  Stream fetchPlannedNotesAsStream(String username) => noteProvider.fetchPlannedNotesAsStream(username);

  Future getNumOfNotes(String categoryID) => noteProvider.getNumOfNotes(categoryID);

  Future getNumOfImportanceNotes(String username) => noteProvider.getNumOfImportanceNotes(username);

  Future insertNote(NoteModel note) async {
    await noteProvider.insertNote(note);
    updateNumOfNotes(note.category);
  }

  Future deleteNote(NoteModel note) async {
    await noteProvider.deleteNote(note.id);
    updateNumOfNotes(note.category);
  }

  Future updateNote(NoteModel note) async {
    await noteProvider.updateNote(note);
    updateNumOfNotes(note.category);
  }

  Future updateNumOfNotes(CategoryModel category) async {
    await noteProvider.getNumOfNotes(category.id).then((value) {
      category.numOfNotes = value;
    });
    categoryProvider.updateCategory(category);
  }
}