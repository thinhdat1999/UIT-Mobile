import 'package:dt_todo/blocs/category_blocs.dart';
import 'package:dt_todo/models/category_model.dart';
import 'package:dt_todo/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SmartList {

  static List categorySmartList = [
    CategoryModel(icon: 'wb_sunny', color: Colors.amberAccent, name: 'My Day', numOfNotes: 0, isSmartList: true, index: 0),
    CategoryModel(icon: 'star_border', color: Colors.red, name: 'Importance', numOfNotes: 0, isSmartList: true, index: 1),
    CategoryModel(icon: 'date_range', color: Colors.greenAccent, name: 'Plan', numOfNotes: 0, isSmartList: true, index: 2),
    //CategoryModel(icon: 'Book', color: Colors.greenAccent, name: 'Tasks', numOfNotes: 0, isSmartList: true, index: 3),

  ];
}