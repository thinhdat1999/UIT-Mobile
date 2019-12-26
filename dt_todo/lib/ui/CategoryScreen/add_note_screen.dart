import 'package:dt_todo/blocs/note_blocs.dart';
import 'package:dt_todo/models/category_model.dart';
import 'package:dt_todo/models/note_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AddNoteScreen extends StatefulWidget {
  final CategoryModel category;

  const AddNoteScreen({Key key, this.category}) : super(key: key);
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  bool isEnable = false;
  TextEditingController controller;
  DateTime dateTime;
  @override void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
    isEnable = false;
    dateTime = null;
  }
  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Checkbox(
                    value: false,
                    onChanged: (bool value){
                    },
                  ),
                  new Container(
                      width: 250,
                      child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: controller,
                              textInputAction: TextInputAction.done,
                              autofocus: true,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Add task'),
                              validator: (val) => val.isEmpty ? 'Enter list title' : null,
                              onChanged: (val) {
                                if(val.isNotEmpty) {
                                  setState(() {
                                    isEnable = true;
                                  });
                                }
                                else {
                                  setState(() {
                                    isEnable = false;
                                  });
                                }
                              },
                            )
                          ])
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.add),
                    color: Colors.blue,
                    onPressed: isEnable ? () async {
                      NoteModel note = new NoteModel(title: controller.text,
                          description: null,
                          isDone: false,
                          isImportance: widget.category.index == 1 ? true : false,
                          category: widget.category,
                          createDate: DateTime.now(),
                          dueDate: dateTime);
                          //dueDate: DateTime.now().add(Duration(days: 2)));
                      NoteBloc().insertNote(note);
                      Navigator.pop(context);
                    } : null,
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    color: Colors.lightBlueAccent,
                    onPressed: () {
                      DatePicker.showDateTimePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(2017, 1, 1),
                          maxTime: DateTime(2099, 1, 1), onChanged: (date) {
                          }, onConfirm: (date) {
                            dateTime = date;
                          }, currentTime: DateTime.now(), locale: LocaleType.en);
                    },
                  ),
                  IconButton(
                    icon:Icon(Icons.cancel),
                    color: Colors.red,
                    onPressed: ()=>{
                      Navigator.of(context).pop()
                    },
                  )
                ],
              ),
            ])
    );
  }
}
