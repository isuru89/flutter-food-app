// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Menu _$MenuFromJson(Map<String, dynamic> json) {
  return Menu(
    name: json['name'] as String,
    fromTime: json['fromTime'] as String,
    endTime: json['endTime'] as String,
    items: (json['items'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          k, e == null ? null : MenuItem.fromJson(e as Map<String, dynamic>)),
    ),
    categories: (json['categories'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k,
          e == null ? null : MenuCategory.fromJson(e as Map<String, dynamic>)),
    ),
    addOns: (json['addOns'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          k, e == null ? null : ItemAddOn.fromJson(e as Map<String, dynamic>)),
    ),
    addOnGroups: (json['addOnGroups'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          k,
          e == null
              ? null
              : ItemAddOnGroup.fromJson(e as Map<String, dynamic>)),
    ),
  );
}

Map<String, dynamic> _$MenuToJson(Menu instance) => <String, dynamic>{
      'name': instance.name,
      'fromTime': instance.fromTime,
      'endTime': instance.endTime,
      'items': instance.items?.map((k, e) => MapEntry(k, e?.toJson())),
      'categories':
          instance.categories?.map((k, e) => MapEntry(k, e?.toJson())),
      'addOns': instance.addOns?.map((k, e) => MapEntry(k, e?.toJson())),
      'addOnGroups':
          instance.addOnGroups?.map((k, e) => MapEntry(k, e?.toJson())),
    };
