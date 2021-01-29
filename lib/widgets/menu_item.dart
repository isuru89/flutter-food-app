import 'dart:math';

import 'package:flutter/material.dart';
import 'package:food_app/model/menu/menu_item.dart';
import 'package:food_app/widgets/menu_item_image.dart';
import 'package:food_app/widgets/price_label.dart';
import 'package:food_app/widgets/food_label.dart';

import 'package:food_app/constants.dart';

class MenuItemWidget extends StatelessWidget {

  static final rnd = Random(123232);

  final MenuItem menuItem;
  final Function(MenuItem) onClicked;

  const MenuItemWidget({Key key, this.menuItem, this.onClicked}) : super(key: key);

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
                        imageUrl: menuItem.images['lg'],
                        isSoldOut: rnd.nextInt(5) % 2 == 0,
                        width: kMenuItemImageSize,
                        height: kMenuItemImageSize,
                      )
                    ),
                    SizedBox(width: kDoublePadding),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Labels.createItemNameLabel(menuItem.name,
                              themeData.textTheme.headline4.copyWith(fontWeight: FontWeight.w800)
                          ),
                          SizedBox(height: kPadding),
                          Labels.createFoodLabels(
                              menuItem.tags ?? []
                          )
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
                    Labels.createCalorieLabel(menuItem.calories, themeData.textTheme.subtitle1)
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