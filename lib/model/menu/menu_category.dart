
import 'package:json_annotation/json_annotation.dart';

import 'menu_item.dart';

part 'menu_category.g.dart';

@JsonSerializable(explicitToJson: true)
class MenuCategory {

  final String name;
  final String id;
  final List<MenuItem> items;

  MenuCategory(this.id, this.name, { this.items });

  factory MenuCategory.fromJson(Map<String, dynamic> json) => _$MenuCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$MenuCategoryToJson(this);
}