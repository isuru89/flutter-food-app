

import 'package:delizious/model/restaurant.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {

  final String email;
  final String name;
  final String phoneNo;

  final List<Address> addresses;
  final List<PaymentCard> paymentCards;

  User({ this.email, this.name, this.phoneNo, this.addresses, this.paymentCards });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class PaymentCard {

  final String id;
  final String cardNo;
  final String securityCode;
  final String expiration;
  final String zipCode;

  bool isDefault;

  PaymentCard({this.id, this.cardNo, this.securityCode, this.expiration, this.zipCode, this.isDefault});

  factory PaymentCard.fromJson(Map<String, dynamic> json) => _$PaymentCardFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentCardToJson(this);

  PaymentCard clone() {
    return PaymentCard.fromJson(this.toJson());
  }
}

@JsonSerializable()
class FavouriteItem {
  final String restaurantId;
  final String itemId;

  FavouriteItem({this.restaurantId, this.itemId});

  factory FavouriteItem.fromJson(Map<String, dynamic> json) => _$FavouriteItemFromJson(json);
  Map<String, dynamic> toJson() => _$FavouriteItemToJson(this);

  @override
  String toString() {
  return itemId + " " + restaurantId;
   }
}