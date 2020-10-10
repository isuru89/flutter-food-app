import 'dart:math';

import 'package:flutter/material.dart';
import 'package:food_app/model/menu.dart';
import 'package:food_app/widgets/menu_item_image.dart';
import 'package:food_app/widgets/price_label.dart';
import 'package:food_app/widgets/food_label.dart';

final rnd = Random(12345);

final foodLabels = ["Milk", "Soya", "Fish", "Nuts", "Glutten", "Meat", "Halal", "Spicy"];

class MenuItemWidget extends StatelessWidget {

  static final rnd = Random(123232);

  final MenuItem menuItem;
  final Function(MenuItem) onClicked;

  const MenuItemWidget({Key key, this.menuItem, this.onClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    var isRange = rnd.nextInt(21) % 2 == 0;
    return InkWell(
      onTap: () => this.onClicked(menuItem),
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Container(
          height: 140,
          margin: EdgeInsets.symmetric(vertical: 4),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  children: [
                    Hero(
                      tag: "menu-item-${menuItem.id}",
                      child: MenuItemImage(imageUrl: menuItem.images['lg'], isSoldOut: rnd.nextInt(5) % 2 == 0, width: 124, height: 124,)
                    ),
                    SizedBox(width: 16),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Labels.createItemNameLabel(menuItem.name, themeData.textTheme.headline4.copyWith(fontWeight: FontWeight.w800)),
                          SizedBox(height: 4),
                          Labels.createFoodLabels(List.generate(rnd.nextInt(foodLabels.length), (index) => foodLabels[index]))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (isRange)
                      PriceLabel(rnd.nextInt(15) + 0.99)
                    else
                      PriceRangeLabel.create(rnd.nextInt(15) + 0.99, 15 + rnd.nextInt(20) + 0.99),
                    SizedBox(height: 4),
                    Labels.createCalorieLabel(100 + rnd.nextInt(512), themeData.textTheme.subtitle1)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}