
import 'package:food_app/model/menu/menu.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant.g.dart';

@JsonSerializable(explicitToJson: true)
class Restaurant {

  final String id;
  final String name;
  final String bannerUrl;

  final List<Menu> menuSessions;

  Restaurant({ this.id, this.name, this.bannerUrl, this.menuSessions });

  factory Restaurant.fromJson(Map<String, dynamic> json) => _$RestaurantFromJson(json);
  Map<String, dynamic> toJson() => _$RestaurantToJson(this);

}