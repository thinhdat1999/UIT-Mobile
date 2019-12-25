import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class IconHelper {
  IconData getIconByName(String name) {
    switch (name) {
      case "wb_sunny": return Icons.wb_sunny;
      case "new_list": return Icons.format_list_bulleted;
      case "star_border": return Icons.star_border;
      case "date_range": return Icons.date_range;
      case "audiotrack": return Icons.audiotrack;
      case "email": return Icons.email;
      case "work": return Icons.work;
      case "shopping_cart": return Icons.shopping_cart;
      case "add_location": return Icons.add_location;
      case "videogame_asset": return Icons.videogame_asset;
      case "cake": return Icons.cake;
      case "business_center": return Icons.business_center;
      case "fitness_center": return Icons.fitness_center;
      case "school": return Icons.school;
    }
  }

  Icon getIconFromJson(String name, String color) {
    int value = int.parse(color, radix: 16);
    return Icon(getIconByName(name), color: Color(value));
  }
}