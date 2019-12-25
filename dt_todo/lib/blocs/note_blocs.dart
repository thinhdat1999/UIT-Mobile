import 'package:dt_todo/models/category_model.dart';
import 'package:dt_todo/models/note_model.dart';
import 'package:dt_todo/provider/repository.dart';

class NoteBloc {

  final repository = Repository();

  Future getNotesByCategory(String categoryID) => repository.getNotesByCategory(categoryID);

  Stream fetchNotesAsStream(String categoryID) => repository.fetchNotesAsStream(categoryID);

  Future insertNote(NoteModel note) => repository.insertNote(note);
}