import 'package:circular_check_box/circular_check_box.dart';
import 'package:dt_todo/blocs/note_blocs.dart';
import 'package:dt_todo/models/category_model.dart';
import 'package:dt_todo/models/note_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class DetailsNoteScreen extends StatefulWidget{
  NoteModel note;
  DetailsNoteScreen({this.note});
  @override
  _DetailsNoteScreen createState()=>_DetailsNoteScreen();
}

// ignore: camel_case_types
class _DetailsNoteScreen extends State<DetailsNoteScreen> {

  TextEditingController textEditingController;
  TextEditingController descriptionController;
  bool isDone ;
  DateTime dateTime;
  String Date;
  String Time;

  @override
  void initState() {
    isDone = widget.note.isDone;
    textEditingController = TextEditingController(text: widget.note.title);
    descriptionController = TextEditingController(text: widget.note.description);
    dateTime = widget.note.dueDate;
    Date = widget.note.dueDate != null ? widget.note.dueDate.toIso8601String().substring(0, 10) : " Pick due date";
    Time = widget.note.dueDate != null ? widget.note.dueDate.toIso8601String().substring(11, 16) : "";
    super.initState();
  }

  void changeState(){
    setState(() {
      isDone = !isDone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note.category.name),
        backgroundColor: widget.note.category.index == 0 ? Colors.yellow : widget.note.category.index == 1 ? Colors.red[100] : widget.note.category.index == 2 ? Colors.green[100] : Colors.lightGreen[100],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30)
            )
        ),
        elevation: 5.0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Theme(
            data: Theme.of(context).copyWith(accentColor: Colors.grey),
            child: Row(
              children: <Widget>[
                new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CircularCheckBox(
                        value: isDone,
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        onChanged: (bool x) {
                          changeState();
                        }
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width/1.2,
                        child: TextFormField(
                          decoration: new InputDecoration(
                            hintText: 'Rename title',
                              border: InputBorder.none
                          ),
                          style: new TextStyle(color: Colors.white,fontSize: 20),
                          controller: textEditingController,
                          validator: (val) => val.isEmpty ? widget.note.title : null,
                        )
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        leading: BackButton(
          onPressed: () {
            widget.note.dueDate = dateTime;
            widget.note.description = descriptionController.text.isEmpty ? '' : descriptionController.text;
            widget.note.title = textEditingController.text.isEmpty? widget.note.title : textEditingController.text;
            widget.note.isDone = isDone;
            NoteBloc().updateNote(widget.note);
            Navigator.pop(context);
          },
        ),
      ),
      body: Builder(
          builder: (context) => ListView(
            padding: const EdgeInsets.all(15),
            children: <Widget>[
              Container(
                  alignment: Alignment.centerLeft,
                  child: FlatButton.icon(
                      onPressed: ()=>{
                        widget.note.isMyDay = !widget.note.isMyDay,
                        NoteBloc().updateNote(widget.note),
                        setState(() {})
                      },
                      icon: Icon(Icons.wb_sunny,color: Colors.yellow,),
                      label: widget.note.isMyDay ? Text('Added to My Day', style: TextStyle(
                        color: Colors.blueAccent,
                      )) : Text('Add to my day')
                  )),
              Row(
                children: <Widget>[
                  FlatButton.icon(
                    onPressed: () {
                      DatePicker.showDateTimePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(2017, 1, 1),
                          maxTime: DateTime(2099, 1, 1), onChanged: (date) {
                            print('change $date');
                          }, onConfirm: (date) {
                            dateTime = date;
                            setState(() {
                              Date = date.toIso8601String().substring(0,10);
                              Time = date.toIso8601String().substring(11,16);
                            });
                          }, currentTime: DateTime.now(), locale: LocaleType.en);
                    },
                    icon: Icon(Icons.calendar_today),
                    label: Text(Date),
                  ),
                  FlatButton.icon(
                    onPressed: () {
                    },
                    icon: Icon(Icons.alarm),
                    label: Text(Time),
                  ),
                ],
              ),

              Container(alignment: Alignment.centerLeft,
                  child:  TextField(
                    controller: descriptionController,
                    textInputAction: TextInputAction.done,
                    maxLines: 4,
                  )),
            ],
          )
      ),
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: 10),
            Text('Create date: ' + widget.note.createDate.toString().substring(0, widget.note.createDate.toString().length - 3),
            style: TextStyle(fontSize: 16),),
            Spacer(),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: new Text('Delete note'),
                        content: new Text('Do you want to delete this note forever?'),
                        actions: <Widget>[
                          new FlatButton(
                            child: new Text("Cancel"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          new FlatButton(
                            child: new Text('Accept'),
                            onPressed: () async {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              NoteBloc().deleteNote(widget.note);

                            },
                          )
                        ],
                      );
                    }
                );
                /*Navigator.pop(context);
                NoteBloc().deleteNote(widget.note);*/
              },
              iconSize: 30,
            )
          ],
        )
      ),
    );
  }

}