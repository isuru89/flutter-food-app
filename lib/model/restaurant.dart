
import 'package:delizious/model/menu/menu.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant.g.dart';

@JsonSerializable(explicitToJson: true)
class Restaurant {

  final String id;
  final String name;
  final Address address;
  final String phone;
  final String email;
  final List<String> cuisines;
  final String bannerUrl;

  final List<Menu> menuSessions;

  Restaurant({ this.id, this.name, this.bannerUrl, this.menuSessions, this.address, this.phone,
    this.cuisines, this.email });

  factory Restaurant.fromJson(Map<String, dynamic> json) => _$RestaurantFromJson(json);
  Map<String, dynamic> toJson() => _$RestaurantToJson(this);

}

@JsonSerializable()
class Address {
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String state;
  final String zipCode;

  Address(this.addressLine1, this.addressLine2, this.city, this.state, this.zipCode);

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}