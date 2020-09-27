

import 'package:flutter/material.dart';


class Menu {

  final String name;
  final String fromTime;
  final String endTime;
  int _start;
  int _end;

  Menu({ this.name, this.fromTime, this.endTime }) {
    _start = int.parse(fromTime.split(":")[0]) * 60 +  int.parse(fromTime.split(":")[1]);
    _end = int.parse(endTime.split(":")[0]) * 60 + int.parse(endTime.split(":")[1]);
  }

  bool isAvailable() {
    var timeOfDay = TimeOfDay.fromDateTime(DateTime.now());
    var mins = timeOfDay.hour * 60 + timeOfDay.minute;
    return mins <= _end;
  }

}

class MenuItem {

  final String id;
  final String name;
  final double price;
  final String description;
  final double calories;
  final Map<String, String> images;

  MenuItem(this.id, this.name, {this.price, this.description, this.calories, this.images});


}