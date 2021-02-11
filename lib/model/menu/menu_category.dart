
import 'package:json_annotation/json_annotation.dart';

part 'menu_category.g.dart';

@JsonSerializable(explicitToJson: true)
class MenuCategory {

  final String name;
  final String id;
  final List<String> itemIds;
  final int priority;

  MenuCategory(this.id, this.name, { this.itemIds, this.priority = 1 });

  factory MenuCategory.fromJson(Map<String, dynamic> json) => _$MenuCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$MenuCategoryToJson(this);
}