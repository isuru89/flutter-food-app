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
    address: json['address'] == null
        ? null
        : Address.fromJson(json['address'] as Map<String, dynamic>),
    phone: json['phone'] as String,
    cuisines: (json['cuisines'] as List)?.map((e) => e as String)?.toList(),
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$RestaurantToJson(Restaurant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address?.toJson(),
      'phone': instance.phone,
      'email': instance.email,
      'cuisines': instance.cuisines,
      'bannerUrl': instance.bannerUrl,
      'menuSessions': instance.menuSessions?.map((e) => e?.toJson())?.toList(),
    };

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
    json['addressLine1'] as String,
    json['addressLine2'] as String,
    json['city'] as String,
    json['state'] as String,
    json['zipCode'] as String,
  );
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'addressLine1': instance.addressLine1,
      'addressLine2': instance.addressLine2,
      'city': instance.city,
      'state': instance.state,
      'zipCode': instance.zipCode,
    };
