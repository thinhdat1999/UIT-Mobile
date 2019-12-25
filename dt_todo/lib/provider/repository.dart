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

  Future fetchCategories(String username) => categoryProvider.fetchCategories(username);

  Stream fetchCategoriesAsStream(String username) => categoryProvider.fetchCategoriesAsStream(username);

  Future getCategoriesByUsername(String username) => categoryProvider.getCategoriesByUsername(username);

  Future getSmartCategoriesByUsername(String username) => categoryProvider.getSmartCategoriesByUsername(username);

  Future insertCategory(CategoryModel category) => categoryProvider.insertCategory(category);

  Future deleteCategory(String id) => categoryProvider.deleteCategory(id);

  Future updateCategory(CategoryModel category) => categoryProvider.updateCategory(category);

  Future getNotesByCategory(String categoryID) => noteProvider.getNotesByCategory(categoryID);

  Stream fetchNotesAsStream(String categoryID) => noteProvider.fetchNotesAsStream(categoryID);
  Future insertNote(NoteModel note) async {
    noteProvider.insertNote(note);
    note.category.numOfNotes += 1;
    categoryProvider.updateCategory(note.category);
  }


}