import 'dart:math';

import 'package:delizious/widgets/food_rating.dart';
import 'package:flutter/material.dart';
import 'package:delizious/model/menu/menu_item.dart';
import 'package:delizious/widgets/menu_item_image.dart';
import 'package:delizious/widgets/price_label.dart';
import 'package:delizious/widgets/food_label.dart';

import 'package:delizious/constants.dart';
import '../extensions.dart';

class MenuItemWidget extends StatelessWidget {
  static final rnd = Random(123232);

  final MenuItem menuItem;
  final Function(MenuItem) onClicked;

  const MenuItemWidget({Key key, this.menuItem, this.onClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return InkWell(
      onTap: () => this.onClicked(menuItem),
      child: Card(
        margin: EdgeInsets.all(kPadding),
        elevation: kMenuItemCardElevation,
        child: Container(
          height: kMenuItemHeight,
          margin: EdgeInsets.symmetric(vertical: kPadding),
          padding: EdgeInsets.all(kPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  children: [
                    Hero(
                        tag: "menu-item-${menuItem.id}",
                        child: MenuItemImage(
                          imageUrl: menuItem.imageUrl,
                          isSoldOut: rnd.nextInt(5) % 2 == 0,
                          width: kMenuItemImageSize,
                          height: kMenuItemImageSize,
                        )),
                    SizedBox(width: kDoublePadding),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Labels.createItemNameLabel(
                              menuItem.title,
                              themeData.textTheme.headline4
                                  .copyWith(fontWeight: FontWeight.w800)),
                          SizedBox(height: kPadding),
                          FoodRating(menuItem.rating / 10,),
                          SizedBox(height: kPadding,),
                          Labels.createFoodLabels(
                              menuItem.itemAttributes.dietaryLabels ?? []),
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
                    PriceLabel(menuItem.price),
                    SizedBox(height: kPadding),
                    if (menuItem.hasCalories)
                      Labels.createCalorieLabel(
                        menuItem.calories,
                        themeData.textTheme.subtitle1,
                      )
                  ],
                ),
              )
            ],
          ),
        ),
      ).addNeumorphism(
        blurRadius: 15,
        borderRadius: 15,
        offset: Offset(5, 5),
        topShadowColor: Colors.white60,
        bottomShadowColor: themeData.backgroundColor.withOpacity(0.15),
      ),
    );
  }
}
