
import 'package:json_annotation/json_annotation.dart';

part 'menu_item.g.dart';

@JsonSerializable(explicitToJson: true)
class MenuItem {

  final String id;
  final String name;
  final double price;
  final String description;
  final double calories;
  final Map<String, String> images;
  final List<ItemAddOnGroup> addOnGroups;

  MenuItem(this.id, this.name, {this.price, this.description, this.calories, this.images, this.addOnGroups});

  factory MenuItem.fromJson(Map<String, dynamic> json) => _$MenuItemFromJson(json);
  Map<String, dynamic> toJson() => _$MenuItemToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ItemAddOnGroup {

  final String id;
  final String name;

  final int minItems;
  final int maxItems;
  final List<ItemAddOn> addOns;

  ItemAddOnGroup(this.id, this.name, this.minItems, this.maxItems, this.addOns);

  factory ItemAddOnGroup.fromJson(Map<String, dynamic> json) => _$ItemAddOnGroupFromJson(json);
  Map<String, dynamic> toJson() => _$ItemAddOnGroupToJson(this);
}

@JsonSerializable()
class ItemAddOn {

  final String id;
  final String name;
  final double price;

  ItemAddOn(this.id, this.name, this.price);

  factory ItemAddOn.fromJson(Map<String, dynamic> json) => _$ItemAddOnFromJson(json);
  Map<String, dynamic> toJson() => _$ItemAddOnToJson(this);
}