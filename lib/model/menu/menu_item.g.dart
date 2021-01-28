// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuItem _$MenuItemFromJson(Map<String, dynamic> json) {
  return MenuItem(
    json['id'] as String,
    json['name'] as String,
    price: (json['price'] as num)?.toDouble(),
    description: json['description'] as String,
    calories: (json['calories'] as num)?.toDouble(),
    images: (json['images'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
    addOnGroups: (json['addOnGroups'] as List)
        ?.map((e) => e == null
            ? null
            : ItemAddOnGroup.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MenuItemToJson(MenuItem instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'description': instance.description,
      'calories': instance.calories,
      'images': instance.images,
      'addOnGroups': instance.addOnGroups?.map((e) => e?.toJson())?.toList(),
    };

ItemAddOnGroup _$ItemAddOnGroupFromJson(Map<String, dynamic> json) {
  return ItemAddOnGroup(
    json['id'] as String,
    json['name'] as String,
    json['minItems'] as int,
    json['maxItems'] as int,
    (json['addOns'] as List)
        ?.map((e) =>
            e == null ? null : ItemAddOn.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ItemAddOnGroupToJson(ItemAddOnGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'minItems': instance.minItems,
      'maxItems': instance.maxItems,
      'addOns': instance.addOns?.map((e) => e?.toJson())?.toList(),
    };

ItemAddOn _$ItemAddOnFromJson(Map<String, dynamic> json) {
  return ItemAddOn(
    json['id'] as String,
    json['name'] as String,
    (json['price'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$ItemAddOnToJson(ItemAddOn instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
    };
