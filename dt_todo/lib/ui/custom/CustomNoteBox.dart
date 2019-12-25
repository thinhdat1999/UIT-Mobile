import 'package:dt_todo/blocs/note_blocs.dart';
import 'package:dt_todo/helper/DBHelper.dart';
import 'package:dt_todo/models/category_model.dart';
import 'package:dt_todo/models/note_model.dart';
import 'package:dt_todo/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomNoteBox extends StatefulWidget {
  NoteModel note;

  CustomNoteBox({this.note});
  @override
  _CustomNoteBoxState createState() => _CustomNoteBoxState();
}

class _CustomNoteBoxState extends State<CustomNoteBox> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: _printHello,
      child: Container(
        color: Colors.blue,
        child: Row(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            /*Padding(
              padding: EdgeInsets.all(5),
              child: Icon(
                Icons.format_list_bulleted,
                color: Colors.red,
                size: 25,
              ),
            ),*/
            Padding(
                padding: EdgeInsets.all(5),
                child: Checkbox(
                  value: widget.note.isDone,
                  onChanged: (bool value) {
                    _setDone(value);
                  },
                )
            ),
            SizedBox(width: 18),
            Text(widget.note.title,
              style: widget.note.isDone
                  ? TextStyle(decoration: TextDecoration.lineThrough)
                  : TextStyle(decoration: TextDecoration.none),
            ),
            Spacer(),
            IconButton(
                icon: (widget.note.isImportance ? Icon(Icons.star) : Icon(
                    Icons.star_border)),
                color: Colors.amber,
                iconSize: 25,
                onPressed: _setImportance)
          ],

        ),
      ),
    );
  }

  void _setImportance() async {
    final doc = DBHelper('categories');
    final response = await doc.ref.where('username', isEqualTo: UserModel().username).where('name', isEqualTo: 'Importance').limit(1).getDocuments();
    if (response.documents.isEmpty) return null;
    final json = response.documents.elementAt(0);
    final importanceCategory = CategoryModel.fromMap(json.data, json.documentID);
    setState(() {
      widget.note.isImportance = !widget.note.isImportance;
      if(widget.note.isImportance) {
        //TODO: add to importance
        NoteModel importanceNote = widget.note;
        importanceNote.category = importanceCategory;
        NoteBloc().insertNote(importanceNote);
        importanceCategory.numOfNotes++;
        print(importanceCategory.id);
      }
      else {

        importanceCategory.numOfNotes--;
      }
    });
  }

  void _setDone(bool value) {
    setState(() {
      widget.note.isDone = value;
    });
  }

  void _printHello() {
    print('hello');
  }
}
