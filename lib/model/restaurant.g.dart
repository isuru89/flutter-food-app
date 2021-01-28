// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Restaurant _$RestaurantFromJson(Map<String, dynamic> json) {
  return Restaurant(
    id: json['id'] as String,
    name: json['name'] as String,
    bannerUrl: json['bannerUrl'] as String,
    menuSessions: (json['menuSessions'] as List)
        ?.map(
            (e) => e == null ? null : Menu.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$RestaurantToJson(Restaurant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'bannerUrl': instance.bannerUrl,
      'menuSessions': instance.menuSessions?.map((e) => e?.toJson())?.toList(),
    };
