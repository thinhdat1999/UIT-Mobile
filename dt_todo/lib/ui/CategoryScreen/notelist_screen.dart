import 'package:dt_todo/blocs/note_blocs.dart';
import 'package:dt_todo/helper/IconHelper.dart';
import 'package:dt_todo/models/category_model.dart';
import 'package:dt_todo/models/note_model.dart';
import 'package:dt_todo/ui/CategoryScreen/note_list.dart';
import 'package:dt_todo/ui/custom/CategoryBox.dart';
import 'package:dt_todo/ui/custom/CustomNoteBox.dart';
import 'package:dt_todo/ui/custom/EditCategory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class NoteListScreen extends StatefulWidget {
  final CategoryModel category;
  const NoteListScreen({this.category});

  @override
  _NoteListScreenState createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  static List noteList;

/*  Future future;

  Future loadNoteList() async {
    if(widget.category != null) {
      noteList = await NoteBloc().getNotesByCategory(widget.category.id);
    }
  }*/

/*
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.category == null) {
      print('category null');
    }
    //future = loadNoteList();
  }
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              snap: false,
              floating: false,
              expandedHeight: 100.0,
              flexibleSpace: FlexibleSpaceBar(
                //titlePadding: EdgeInsetsDirectional.only(start: 0),
                centerTitle: true,
                title: MediaQuery.removePadding(
                  context: context,
                  removeLeft: true,
                  removeBottom: true,
                  child: Stack(
                    children: [
                      new Positioned(
                        //left: MediaQuery.of(context).size.width / 5.2,
                        left: MediaQuery
                            .of(context)
                            .size
                            .width / 5.2,
                        bottom: 0,
                        child: Transform.translate(
                          child: GestureDetector(
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  widget.category == null ? SizedBox() : Icon(IconHelper().getIconByName(
                                      widget.category.icon),
                                      color: widget.category.color),
                                  SizedBox(width: 5),
                                  widget.category == null ? SizedBox() : Text(widget.category.name),
                                ],
                              ),
                            ),
                          ),
                          offset: Offset(0, 1.5),
                        ),
                      ),
                    ],
                  ),
                ),
                /*background: GestureDetector(
                  onTap: () async {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (_) {
                          return EditDialog(category: widget.category);
                        }
                    );
                  }
                ),*/
              ),
              actions: <Widget>[
                PopupMenuButton<String>(
                  itemBuilder: (context) =>
                  [
                    PopupMenuItem(value: 'Settings', child: Text('Settings')),
                    PopupMenuItem(value: 'Sort', child: Text('Sort')),
                  ],
                ),
              ],
            ),
            widget.category == null || widget.category.numOfNotes == 0 ? SliverToBoxAdapter() :
            SliverToBoxAdapter(
              child: StreamBuilder(
                  stream: NoteBloc().fetchNotesAsStream(widget.category.id),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Center(
                            child: Text("Không có kết nối mạng"));
                      case ConnectionState.waiting:
                        return Center(
                          child: new CircularProgressIndicator(),
                        );
                      default:
                        if (snapshot.hasError) {
                          print(snapshot.error);
                          return Center(child: Text("Lỗi kết nối"));
                        }
                        else {
                          noteList = snapshot.data.documents.map(
                                  (doc) => NoteModel.fromMap(doc.data, doc.documentID)).toList();
                          return Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: noteList.map((note) => CustomNoteBox(note: note)).toList(),
                              )
                          );
                        }
                        /*else if (noteList.isEmpty)
                          return Text('null');
                        else
                          return Container(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: noteList.map((note) => CustomNoteBox(note: note)).toList(),
                            )
                          );*/
                    }
                  }
              ),
            ),
          ]
      ),
      floatingActionButton: new FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: addNote,
      )
      ,
    );
  }

  void addNote() {
    NoteModel note = new NoteModel(title: 'abc',
        description: 'def',
        isDone: false,
        isImportance: false,
        category: widget.category,
        createDate: DateTime.now(),
        dueDate: DateTime.now().add(Duration(days: 2)));
    NoteBloc().insertNote(note);
    if(widget.category.numOfNotes == 1) setState(() {});
  }
}