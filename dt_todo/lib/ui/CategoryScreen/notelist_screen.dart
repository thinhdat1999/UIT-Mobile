import 'package:dt_todo/models/CategoryModel.dart';
import 'package:dt_todo/ui/custom/CategoryBox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SABT.dart';

class NoteListScreen extends StatefulWidget {
  final CategoryModel category;

  NoteListScreen({this.category});

  @override
  _NoteListScreenState createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  bool _isStreching = false;

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
                /*flexibleSpace: FlexibleSpaceBar(
                    titlePadding: EdgeInsetsDirectional.only(start: 18, bottom: 15),
                    title: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          widget.category.icon,
                          SizedBox(width: 5),
                          Text(widget.category.name),
                        ],
                      ),
                    ),*/
                //),
                flexibleSpace: FlexibleSpaceBar(
                  title: SABT(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          widget.category.icon,
                          SizedBox(width: 5),
                          Text(widget.category.name),
                        ],
                      ),
                    ),
                  ),
                  background: GestureDetector(
                    onTap: () {print('hi');},
                    child: Container(
                      color: Colors.blue,
                    ),
                  ),
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
              SliverFixedExtentList(
                itemExtent: 50.0,
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return Container(
                      alignment: Alignment.center,
                      color: Colors.lightBlue[100 * (index % 9)],
                      child: Text('List Item $index'),
                    );
                  },
                ),
              ),
            ]
        )
    );
  }
}