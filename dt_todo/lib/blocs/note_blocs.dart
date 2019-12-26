import 'package:dt_todo/models/category_model.dart';
import 'package:dt_todo/models/note_model.dart';
import 'package:dt_todo/provider/repository.dart';

class NoteBloc {

  final repository = Repository();

  Future getNotesByCategory(String categoryID) => repository.getNotesByCategory(categoryID);

  Stream fetchNotesAsStream(String categoryID) => repository.fetchNotesAsStream(categoryID);

  Stream fetchImportanceNotesAsStream(String username) => repository.fetchImportanceNotesAsStream(username);

  Stream fetchPlannedNotesAsStream(String username) => repository.fetchPlannedNotesAsStream(username);

  Future getNumOfNotes(String categoryID) => repository.getNumOfNotes(categoryID);

  Future getNumOfImportanceNotes(String username) => repository.getNumOfImportanceNotes(username);

  Future insertNote(NoteModel note) => repository.insertNote(note);

  Future deleteNote(NoteModel note) => repository.deleteNote(note);

  Future updateNote(NoteModel note) => repository.updateNote(note);

}