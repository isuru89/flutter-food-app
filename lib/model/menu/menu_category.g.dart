// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuCategory _$MenuCategoryFromJson(Map<String, dynamic> json) {
  return MenuCategory(
    json['id'] as String,
    json['name'] as String,
    itemIds: (json['itemIds'] as List)?.map((e) => e as String)?.toList(),
    priority: json['priority'] as int,
  );
}

Map<String, dynamic> _$MenuCategoryToJson(MenuCategory instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'itemIds': instance.itemIds,
      'priority': instance.priority,
    };
