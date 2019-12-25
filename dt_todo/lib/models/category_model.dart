import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dt_todo/models/user_model.dart';
import 'package:flutter/cupertino.dart';

class CategoryModel {
  String id;
  String icon;
  Color color;
  String name;
  int numOfNotes;
  bool isSmartList;
  int index;

  CategoryModel({ this.id, this.icon, this.color, this.name, this.numOfNotes, this.isSmartList, this.index });

  CategoryModel.fromMap(Map snapshot, String id) {
    this.id = id;
    this.icon = snapshot['icon'];
    String valueString = snapshot['color'].split('(0x')[1].split(')')[0];
    int value = int.parse(valueString, radix: 16);
    this.color = Color(value);
    this.name = snapshot['name'] ?? null;
    this.numOfNotes = snapshot['numOfNotes'];
    this.isSmartList = snapshot['isSmartList'];
    this.index = snapshot['index'];
  }


  toJson() {
    return {
      'icon': icon,
      'color': color.toString(),
      'name': name,
      'numOfNotes': numOfNotes,
      'username': UserModel().username,
      'isSmartList': isSmartList ? true : false,
      'index': index
    };
  }
}