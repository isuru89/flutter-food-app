// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuItem _$MenuItemFromJson(Map<String, dynamic> json) {
  return MenuItem(
    id: json['id'] as String,
    title: json['title'] as String,
    price: json['price'],
    description: json['description'] as String,
    rating: (json['rating'] as num)?.toDouble(),
    imageUrl: json['imageUrl'] as String,
    prepTime: json['prepTime'] as int,
    calories: (json['calories'] as num)?.toDouble(),
    itemAttributes: json['itemAttributes'] == null
        ? null
        : ItemAttributes.fromJson(
            json['itemAttributes'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MenuItemToJson(MenuItem instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'description': instance.description,
      'calories': instance.calories,
      'rating': instance.rating,
      'imageUrl': instance.imageUrl,
      'prepTime': instance.prepTime,
      'itemAttributes': instance.itemAttributes?.toJson(),
    };

ItemAttributes _$ItemAttributesFromJson(Map<String, dynamic> json) {
  return ItemAttributes(
    allergens: (json['allergens'] as List)?.map((e) => e as String)?.toList(),
    dietaryLabels:
        (json['dietaryLabels'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$ItemAttributesToJson(ItemAttributes instance) =>
    <String, dynamic>{
      'allergens': instance.allergens,
      'dietaryLabels': instance.dietaryLabels,
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
    json['description'] as String,
  );
}

Map<String, dynamic> _$ItemAddOnToJson(ItemAddOn instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
    };
