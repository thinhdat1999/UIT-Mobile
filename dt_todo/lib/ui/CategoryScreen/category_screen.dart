import 'package:dt_todo/models/CategoryModel.dart';
import 'package:dt_todo/ui/custom/CategoryBox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  static List categorySmartList= [
    CategoryModel(icon: Icon(Icons.wb_sunny, color: Colors.amberAccent,), name: 'My Day', numOfNotes: 0),
    CategoryModel(icon: Icon(Icons.star_border, color: Colors.red), name: 'Importance', numOfNotes: 0),
    CategoryModel(icon: Icon(Icons.date_range, color: Colors.greenAccent), name: 'Plan', numOfNotes: 1),
  ];

  static List categoryList= [
    CategoryModel(icon: Icon(Icons.format_list_bulleted), name: 'Untitle List', numOfNotes: 0),
    CategoryModel(icon: Icon(Icons.format_list_bulleted), name: 'Untitle List', numOfNotes: 0),
    CategoryModel(icon: Icon(Icons.format_list_bulleted), name: 'Untitle List', numOfNotes: 0),
    CategoryModel(icon: Icon(Icons.format_list_bulleted), name: 'Untitle List', numOfNotes: 0),
    CategoryModel(icon: Icon(Icons.format_list_bulleted), name: 'Untitle List', numOfNotes: 0),
    CategoryModel(icon: Icon(Icons.format_list_bulleted), name: 'Untitle List', numOfNotes: 0),
    CategoryModel(icon: Icon(Icons.format_list_bulleted), name: 'Untitle List', numOfNotes: 0),
    CategoryModel(icon: Icon(Icons.format_list_bulleted), name: 'Untitle List', numOfNotes: 0),
    CategoryModel(icon: Icon(Icons.format_list_bulleted), name: 'Untitle List', numOfNotes: 0),
    CategoryModel(icon: Icon(Icons.format_list_bulleted), name: 'Untitle List', numOfNotes: 2),
    CategoryModel(icon: Icon(Icons.format_list_bulleted), name: 'Untitle List', numOfNotes: 1),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //shadow
        bottom: PreferredSize(
            child: Container(
              color: Colors.grey[200], height: 4.0
            ),
            preferredSize: Size.fromHeight(4.0)
        ),
        title: Container(
          padding: EdgeInsets.all(2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.white,
                maxRadius: 18,
              ),
              SizedBox(width: 3),
              Column(
                children: <Widget>[
                  SizedBox(height: 15),
                  Text('vuongthinhdat1@gmail.com', style: TextStyle(fontSize: 16),),
                ],
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: _printHello,
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          //padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
          color: Colors.grey[200],
          child: Column(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: categorySmartList.map((category) => CategoryBox(category: category)).toList(),
              ),
              Divider(indent: 15, height: 15, endIndent: 5, thickness: 1.5),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: categoryList.map((category) => CategoryBox(category: category)).toList(),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          print('Add list');
          print(MediaQuery.of(context).size.width / 5.2);
        },
        child: Container(
          color: Colors.grey[200],
          padding: EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.add, color: Colors.blueAccent),
              SizedBox(width: 20),
              Text('New list', style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 18,
              )),
            ],
          ),
        ),
      ),
    );
  }

  void _printHello() {
    print('hi');
  }
}
