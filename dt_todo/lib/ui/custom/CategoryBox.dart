import 'package:dt_todo/helper/IconHelper.dart';
import 'package:dt_todo/ui/CategoryScreen/notelist_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dt_todo/models/category_model.dart';

class CategoryBox extends StatelessWidget {
  CategoryModel category;
  //List note của category tương ứng.
  List note;
  CategoryBox({this.category});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        //ToDo: thêm 3 screen cho 3 smart list.
       /* switch(category.name) {
          case "My Day":
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyDayScreen(category: category)));

        }*/
        Navigator.push(context, MaterialPageRoute(builder: (context) => NoteListScreen(category: category)));
      },
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.grey[200],
            padding: EdgeInsets.all(8.0),
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(5),
                    child: Icon(IconHelper().getIconByName(category.icon), color: category.color),
                ),
                SizedBox(width: 18),
                Text(category.name),
                Spacer(),
                category.numOfNotes > 0 ? Text(category.numOfNotes.toString()) : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

