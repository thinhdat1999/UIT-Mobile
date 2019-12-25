import 'package:dt_todo/models/category_model.dart';
import 'package:dt_todo/provider/repository.dart';

class CategoryBloc {

  final repository = Repository();

  Future getLastIndex(String username) => repository.getLastIndex(username);

  Future fetchCategories(String username) => repository.fetchCategories(username);

  Stream fetchCategoriesAsStream(String username) => repository.fetchCategoriesAsStream(username);

  Future getCategoriesByUsername(String username) => repository.getCategoriesByUsername(username);

  Future getSmartCategoriesByUsername(String username) => repository.getSmartCategoriesByUsername(username);

  Future insertCategory(CategoryModel category) => repository.insertCategory(category);

  Future deleteCategory(String id) => repository.deleteCategory(id);

  Future updateCategory(CategoryModel category) => repository.updateCategory(category);

}