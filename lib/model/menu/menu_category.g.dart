// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuCategory _$MenuCategoryFromJson(Map<String, dynamic> json) {
  return MenuCategory(
    json['id'] as String,
    json['name'] as String,
    items: (json['items'] as List)
        ?.map((e) =>
            e == null ? null : MenuItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MenuCategoryToJson(MenuCategory instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'items': instance.items?.map((e) => e?.toJson())?.toList(),
    };
