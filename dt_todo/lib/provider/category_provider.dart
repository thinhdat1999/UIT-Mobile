import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dt_todo/helper/DBHelper.dart';
import 'package:dt_todo/models/category_model.dart';
import 'package:dt_todo/models/user_model.dart';
import 'package:flutter/cupertino.dart';

class CategoryProvider {

  final doc = DBHelper('categories');

  List<CategoryModel> listCategories;

  Future getLastIndex(String username) async {
    final response = await doc.ref.where('username', isEqualTo: username).orderBy('index', descending: true).limit(1).getDocuments();
    if (response.documents.isEmpty) return 0;
    final json = response.documents.elementAt(0);
    return CategoryModel.fromMap(json.data, json.documentID).index;
  }

  Future<List<CategoryModel>> fetchCategories(String username) async {
    final response = await doc.ref.where('username', isEqualTo: username).orderBy('index').getDocuments();
    listCategories = response.documents.map((json) => CategoryModel.fromMap(json.data, json.documentID)).toList();
    return listCategories;
  }

  Stream<QuerySnapshot> fetchCategoriesAsStream(String username) {
    return doc.ref.where('username', isEqualTo: username).orderBy('index').snapshots();
  }


  Future getCategoriesByUsername(String username) async {
    var categories = [];
    final response =
        await doc.ref.where('username', isEqualTo: username).where('isSmartList', isEqualTo: false).orderBy('index').getDocuments();
    response.documents.forEach(
        (doc) => categories.add(CategoryModel.fromMap(doc.data, doc.documentID)));
    return categories;
  }

  Future getSmartCategoriesByUsername(String username) async {
    var categories = [];
    final response =
    await doc.ref.where('username', isEqualTo: username)/*.where('isSmartList', isEqualTo: true)*/.orderBy('index').getDocuments();
    response.documents.forEach(
            (doc) => categories.add(CategoryModel.fromMap(doc.data, doc.documentID)));
    return categories;
  }

  Future insertCategory(CategoryModel category) async {
    await doc.ref.add(category.toJson());
  }

  Future deleteCategory(String id) async => await doc.ref.document(id).delete();

  Future updateCategory(CategoryModel category) async =>
      await doc.ref.document(category.id).updateData(category.toJson());
}