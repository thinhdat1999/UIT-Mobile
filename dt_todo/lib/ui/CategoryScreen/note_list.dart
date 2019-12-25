import 'package:dt_todo/ui/custom/CustomNoteBox.dart';
import 'package:flutter/material.dart';

class ListNotes extends StatelessWidget {
  final List listNotes;

  const ListNotes({Key key, this.listNotes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listNotes.length,
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            CustomNoteBox(note: listNotes[index])
          ],
        );
      },
    );
  }
}
