import 'package:delizious/model/menu/menu.dart';
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
  final bool canAddItemInstructions;
  final ItemAttributes itemAttributes;
  final List<String> addOnGroupIds;
  double price;

  @JsonKey(ignore: true)
  List<ItemAddOnGroup> _addOnGroups;
  List<ItemAddOnGroup> get addOnGroups => _addOnGroups;

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
    this.addOnGroupIds,
    this.canAddItemInstructions,
  }) {
    this.price = price / 100;
  }

  factory MenuItem.fromJson(Map<String, dynamic> json) =>
      _$MenuItemFromJson(json);
  Map<String, dynamic> toJson() => _$MenuItemToJson(this);

  get hasCalories => calories != null && calories > 0;

  void synthesize(Menu menuRef) {
    if (addOnGroupIds != null) {
      this._addOnGroups =
          this.addOnGroupIds.map((ag) => menuRef.addOnGroups[ag]).toList();
      this._addOnGroups.sort((ag1, ag2) => ag2.minPermitted.compareTo(ag1.minPermitted));
    }
  }
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
  final String title;

  final int minPermitted;
  final int maxPermitted;
  final List<String> addOnIds;

  @JsonKey(ignore: true)
  List<ItemAddOn> _addOns;
  List<ItemAddOn> get addOns => _addOns;

  ItemAddOnGroup(
      this.id, this.title, this.minPermitted, this.maxPermitted, this.addOnIds);

  factory ItemAddOnGroup.fromJson(Map<String, dynamic> json) =>
      _$ItemAddOnGroupFromJson(json);
  Map<String, dynamic> toJson() => _$ItemAddOnGroupToJson(this);

  void synthesize(Menu menuRef) {
    if (addOnIds != null) {
      this._addOns = this.addOnIds.map((ao) => menuRef.addOns[ao]).toList();
    }
  }
}

@JsonSerializable()
class ItemAddOn {
  final String id;
  final String title;
  final String description;
  double price;
  final bool isSoldOut;

  ItemAddOn({
    this.id,
    this.title,
    price,
    this.description,
    this.isSoldOut,
  }) {
    this.price = price / 100;
  }

  factory ItemAddOn.fromJson(Map<String, dynamic> json) =>
      _$ItemAddOnFromJson(json);
  Map<String, dynamic> toJson() => _$ItemAddOnToJson(this);
}
