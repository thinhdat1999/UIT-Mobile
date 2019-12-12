import 'package:dt_todo/ui/CategoryScreen/category_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MaterialApp(
  title: 'DT To Do',
  initialRoute: '/category_screen',
  routes: {
    '/category_screen': (context) => CategoryScreen()
  },
));

class CustomBoxWidget extends StatefulWidget {
  @override
  _CustomBoxWidgetStage createState() => _CustomBoxWidgetStage();
}

class _CustomBoxWidgetStage extends State<CustomBoxWidget> {
  bool _isImportance = false;
  bool _isDone = false;
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
                value: _isDone,
                onChanged: (bool value) {
                  _setDone(value);
                },
              )
            ),
            SizedBox(width: 18),
            Text('Name of the categories',
             style: _isDone ? TextStyle(decoration: TextDecoration.lineThrough) : TextStyle(decoration: TextDecoration.none),
            ),
            Spacer(),
            IconButton(
                icon: (_isImportance ? Icon(Icons.wb_sunny) : Icon(Icons.star_border)),

                color: Colors.amber,
                iconSize: 25,
                onPressed: _setImportance)
          ],

        ),
      ),
    );
  }
  void _setImportance() {
    setState(() {
      _isImportance = !_isImportance;
    });
  }

  void _setDone(bool value) {
    setState(() {
      _isDone = value;
    });
  }

  void _printHello() {
    print('hello');
  }
}

class NoteBox extends StatefulWidget {
  @override
  _NoteBoxState createState() => _NoteBoxState();
}

class _NoteBoxState extends State<NoteBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(value: null, onChanged: (bool value) {},
          )
        ],
      )
    );
  }
}
