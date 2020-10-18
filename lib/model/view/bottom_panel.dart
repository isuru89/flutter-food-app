
import 'package:flutter/material.dart';

class BottomPanelItem {
  final String name;
  final String route;
  final IconData icon;

  BottomPanelItem(this.name, this.route, this.icon);

  @override
  String toString() {
    return '$name - $route';
  }

}