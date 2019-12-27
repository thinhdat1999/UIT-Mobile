import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class IconHelper {
  IconData getIconByName(String name) {
    switch (name) {
      case "wb_sunny":
        return Icons.wb_sunny;
      case "new_list":
        return Icons.format_list_bulleted;
      case "star_border":
        return Icons.star_border;
      case "date_range":
        return Icons.date_range;
      case "audiotrack":
        return Icons.audiotrack;
      case "email":
        return Icons.email;
      case "work":
        return Icons.work;
      case "shopping_cart":
        return Icons.shopping_cart;
      case "add_location":
        return Icons.add_location;
      case "videogame_asset":
        return Icons.videogame_asset;
      case "cake":
        return Icons.cake;
      case "business_center":
        return Icons.business_center;
      case "fitness_center":
        return Icons.fitness_center;
      case "school":
        return Icons.school;
      case 'Car':
        return Icons.directions_car;
      case 'Bicycle':
        return Icons.directions_bike;
      case 'Boat':
        return Icons.directions_boat;
      case 'Bus':
        return Icons.directions_bus;
      case 'Train':
        return Icons.directions_railway;
      case 'Walk':
        return Icons.directions_walk;
      case 'Work':
        return Icons.work;
      case 'Grocery':
        return Icons.local_grocery_store;
      case 'Photo':
        return Icons.add_photo_alternate;
      case 'Book':
        return Icons.book;
      case 'Plane':
        return Icons.airplanemode_active;
      case 'Baby':
        return Icons.child_care;
      case 'Birthday':
        return Icons.cake;
      case 'Alarm':
        return Icons.alarm;
      case 'Bank':
        return Icons.account_balance;
      case 'Sun':
        return Icons.brightness_high;
      case 'Happy':
        return Icons.mood;
      case 'Moon':
        return Icons.wb_sunny;
      case 'Weather':
        return Icons.cloud;
      case 'Mail':
        return Icons.mail;
      case 'Event':
        return Icons.event_available;
      case 'Heart':
        return Icons.favorite;
      case 'Snow':
        return Icons.ac_unit;
      case 'Cancel':
        return Icons.cancel;
      case 'Check':
        return Icons.check;
      case 'Announcement':
        return Icons.announcement;
      case 'Money':
        return Icons.attach_money;
      case 'Message':
        return Icons.chat;
      case 'Travel':
        return Icons.edit_location;
      case 'FastFood':
        return Icons.fastfood;
      case 'Coffee':
        return Icons.free_breakfast;
      case 'Bus':
        return Icons.music_note;
      case 'Dining':
        return Icons.local_dining;
    }
  }

  Icon getIconFromJson(String name, String color) {
    int value = int.parse(color, radix: 16);
    return Icon(getIconByName(name), color: Color(value));
  }
}