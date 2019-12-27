import 'package:dt_todo/models/category_model.dart';
import 'package:dt_todo/ui/custom/CategoryBox.dart';
import 'package:flutter/material.dart';

class ListCategories extends StatelessWidget {
  final List listCategories;

  const ListCategories({Key key, this.listCategories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listCategories.length,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.grey[200],
          child: Column(
            children: <Widget>[
              CategoryBox(category: listCategories[index]),
              if(listCategories.length > 3 && index == 2)
                  Divider(indent: 15, height: 15, endIndent: 5, thickness: 1.5),
            ],
          ),
        );
      },
    );
  }
}
