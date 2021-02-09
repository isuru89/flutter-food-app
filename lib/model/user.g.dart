// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    email: json['email'] as String,
    name: json['name'] as String,
    phoneNo: json['phoneNo'] as String,
    addresses: (json['addresses'] as List)
        ?.map((e) =>
            e == null ? null : Address.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    paymentCards: (json['paymentCards'] as List)
        ?.map((e) =>
            e == null ? null : PaymentCard.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    favourites: (json['favourites'] as List)
        ?.map((e) => e == null
            ? null
            : FavouriteItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'phoneNo': instance.phoneNo,
      'addresses': instance.addresses?.map((e) => e?.toJson())?.toList(),
      'paymentCards': instance.paymentCards?.map((e) => e?.toJson())?.toList(),
      'favourites': instance.favourites?.map((e) => e?.toJson())?.toList(),
    };

PaymentCard _$PaymentCardFromJson(Map<String, dynamic> json) {
  return PaymentCard(
    id: json['id'] as String,
    cardNo: json['cardNo'] as String,
    securityCode: json['securityCode'] as String,
    expiration: json['expiration'] as String,
    zipCode: json['zipCode'] as String,
  );
}

Map<String, dynamic> _$PaymentCardToJson(PaymentCard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cardNo': instance.cardNo,
      'securityCode': instance.securityCode,
      'expiration': instance.expiration,
      'zipCode': instance.zipCode,
    };

FavouriteItem _$FavouriteItemFromJson(Map<String, dynamic> json) {
  return FavouriteItem(
    restaurantId: json['restaurantId'] as String,
    itemId: json['itemId'] as String,
  );
}

Map<String, dynamic> _$FavouriteItemToJson(FavouriteItem instance) =>
    <String, dynamic>{
      'restaurantId': instance.restaurantId,
      'itemId': instance.itemId,
    };
