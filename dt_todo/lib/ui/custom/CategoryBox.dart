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
        print(category.index);
        Navigator.push(context, MaterialPageRoute(builder: (context) => NoteListScreen(category: category)));
      },
      child: Column(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
                //color: Colors.blue[200],
            ),
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(IconHelper().getIconByName(category.icon), color: category.color),
                ),
                SizedBox(width: 18),
                Text(category.name, style: TextStyle(color: category.index == 0 ? Colors.yellow : category.index == 1 ? Colors.red : category.index == 2 ? Colors.green : Colors.black,fontSize: 20)),
                Spacer(),
                category.numOfNotes > 0 ? Text(category.numOfNotes.toString(),style: TextStyle(fontStyle: FontStyle.italic)) : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

