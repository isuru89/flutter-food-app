import 'package:flutter/material.dart';
import 'package:delizious/model/menu/menu_item.dart';
import 'package:json_annotation/json_annotation.dart';

import 'menu_category.dart';

part 'menu.g.dart';

@JsonSerializable(explicitToJson: true)
class Menu {
  final String name;
  final String fromTime;
  final String endTime;
  final Map<String, MenuItem> items;
  final Map<String, MenuCategory> categories;
  final Map<String, ItemAddOn> addOns;
  final Map<String, ItemAddOnGroup> addOnGroups;

  @JsonKey(ignore: true)
  int _start;
  @JsonKey(ignore: true)
  int _end;

  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);
  Map<String, dynamic> toJson() => _$MenuToJson(this);

  Menu({
    this.name,
    this.fromTime,
    this.endTime,
    this.items,
    this.categories,
    this.addOns,
    this.addOnGroups,
  }) {
    _start = int.parse(fromTime.split(":")[0]) * 60 +
        int.parse(fromTime.split(":")[1]);
    _end = int.parse(endTime.split(":")[0]) * 60 +
        int.parse(endTime.split(":")[1]);
  }

  bool isAvailable() {
    var timeOfDay = TimeOfDay.fromDateTime(DateTime.now());
    var mins = timeOfDay.hour * 60 + timeOfDay.minute;
    return mins <= _end;
  }

  void synthesize() {
    if (this.addOnGroups != null) {
      this.addOnGroups.values.forEach((ag) => ag.synthesize(this));
    }
    if (this.items != null) {
      this.items.values.forEach((it) => it.synthesize(this));
    }
  }
}
