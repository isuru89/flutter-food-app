import 'package:json_annotation/json_annotation.dart';

part 'menu_item.g.dart';

@JsonSerializable(explicitToJson: true)
class MenuItem {
  final String id;
  final String title;
  final String description;
  final double calories;
  final double rating;
  final String imageUrl;
  final int prepTime;
  final ItemAttributes itemAttributes;
  double price;

  MenuItem({
    this.id,
    this.title,
    price,
    this.description,
    this.rating,
    this.imageUrl,
    this.prepTime,
    this.calories = 0,
    this.itemAttributes,
  }) {
    this.price = price / 100;
  }

  factory MenuItem.fromJson(Map<String, dynamic> json) =>
      _$MenuItemFromJson(json);
  Map<String, dynamic> toJson() => _$MenuItemToJson(this);

  get hasCalories => calories != null && calories > 0;
}

@JsonSerializable()
class ItemAttributes {
  final List<String> allergens;
  final List<String> dietaryLabels;

  ItemAttributes({this.allergens, this.dietaryLabels});

  factory ItemAttributes.fromJson(Map<String, dynamic> json) =>
      _$ItemAttributesFromJson(json);
  Map<String, dynamic> toJson() => _$ItemAttributesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ItemAddOnGroup {
  final String id;
  final String name;

  final int minItems;
  final int maxItems;
  final List<ItemAddOn> addOns;

  ItemAddOnGroup(this.id, this.name, this.minItems, this.maxItems, this.addOns);

  factory ItemAddOnGroup.fromJson(Map<String, dynamic> json) =>
      _$ItemAddOnGroupFromJson(json);
  Map<String, dynamic> toJson() => _$ItemAddOnGroupToJson(this);
}

@JsonSerializable()
class ItemAddOn {
  final String id;
  final String name;
  final String description;
  final double price;

  ItemAddOn(this.id, this.name, this.price, this.description);

  factory ItemAddOn.fromJson(Map<String, dynamic> json) =>
      _$ItemAddOnFromJson(json);
  Map<String, dynamic> toJson() => _$ItemAddOnToJson(this);
}
