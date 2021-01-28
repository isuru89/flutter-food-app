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
    categories: (json['categories'] as List)
        ?.map((e) =>
            e == null ? null : MenuCategory.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MenuToJson(Menu instance) => <String, dynamic>{
      'name': instance.name,
      'fromTime': instance.fromTime,
      'endTime': instance.endTime,
      'categories': instance.categories?.map((e) => e?.toJson())?.toList(),
    };
