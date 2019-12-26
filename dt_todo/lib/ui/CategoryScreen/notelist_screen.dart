import 'package:dt_todo/blocs/category_blocs.dart';
import 'package:dt_todo/blocs/note_blocs.dart';
import 'package:dt_todo/helper/IconHelper.dart';
import 'package:dt_todo/models/category_model.dart';
import 'package:dt_todo/models/note_model.dart';
import 'package:dt_todo/models/user_model.dart';
import 'package:dt_todo/ui/CategoryScreen/add_note_screen.dart';
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
const kExpandedHeight = 100.0;


class _NoteListScreenState extends State<NoteListScreen> {
  static List noteList;
  ScrollController _scrollController;
/*  Future future;

  Future loadNoteList() async {
    if(widget.category != null) {
      noteList = await NoteBloc().getNotesByCategory(widget.category.id);
    }
  }*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
  }

  bool get _isShowDialog {
    return _scrollController.hasClients
        && _scrollController.offset  == 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
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
                        child: Container(
                          child: GestureDetector(
                            onTap: () async {
                              _isShowDialog && widget.category.isSmartList == false ?
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (_) {
                                    return EditDialog(category: widget.category);
                                  }
                              ) : null;
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                widget.category == null ? SizedBox() : widget.category.icon == 'new_list' ? SizedBox() : Icon(IconHelper().getIconByName(widget.category.icon), color: widget.category.color),
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
              ),
              actions: widget.category == null ? null : !widget.category.isSmartList ? <Widget>[
                PopupMenuButton<String>(
                  onSelected: choiceAction,
                  itemBuilder: (context) =>
                  [
                    PopupMenuItem(value: 'Rename List', child: Text('Rename List')),
                    PopupMenuItem(value: 'Sort', child: Text('Sort')),
                    PopupMenuItem(value: 'Delete', child: Text('Delete List')),
                  ],
                ),
              ]: null,
            ),
            widget.category == null || widget.category.numOfNotes == 0 ? SliverToBoxAdapter() :
            SliverToBoxAdapter(
              child: StreamBuilder(
                  stream: widget.category.isSmartList ? widget.category.index == 1
                      ? NoteBloc().fetchImportanceNotesAsStream(UserModel().username)
                      : NoteBloc().fetchPlannedNotesAsStream(UserModel().username)
                      : NoteBloc().fetchNotesAsStream(widget.category.id),
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

  void choiceAction(String value) {
    switch(value) {
      case 'Delete':
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) {
            return AlertDialog(
              title: new Text('Delete list'),
              content: new Text('Do you want to delete this list and all children of this list'),
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
                    CategoryBloc().deleteCategory(widget.category.id);

                  },
                )
              ],
            );
          }
        );
        break;
      case 'Rename List':
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (_) {
                return EditDialog(category: widget.category);
              }
          );
        break;
      default:
        break;
    }
  }

  void addNote() async {
    await showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: false,
        context: context,
        builder: (context) {
          return AddNoteScreen(category: widget.category);
        }
    );
    await NoteBloc().getNumOfNotes(widget.category.id).then((value) {
      widget.category.numOfNotes = value;
    });
    if(widget.category.numOfNotes == 1) setState(() {});
  }
}