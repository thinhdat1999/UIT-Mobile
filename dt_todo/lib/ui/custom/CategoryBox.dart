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
        Navigator.push(context, MaterialPageRoute(builder: (context) => NoteListScreen(category: category)));
      },
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.grey[200],
            padding: EdgeInsets.all(8.0),
            child: Row(
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

