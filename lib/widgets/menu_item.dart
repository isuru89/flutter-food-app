import 'dart:math';

import 'package:flutter/material.dart';
import 'package:food_app/model/menu.dart';
import 'package:food_app/widgets/menu_item_image.dart';
import 'package:food_app/widgets/restaurant_header.dart';

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
    var isRange = rnd.nextInt(21) % 3 == 0;
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
                      tag: "menu-item-${menuItem.images['lg']}",
                      child: MenuItemImage(imageUrl: menuItem.images['lg'], isSoldOut: rnd.nextInt(5) % 2 == 0, width: 124, height: 124,)
                    ),
                    SizedBox(width: 16),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${menuItem.name}',
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: themeData.textTheme.headline4.copyWith(fontWeight: FontWeight.w800),
                          ),
                          SizedBox(height: 4),
                          Wrap(
                            children: List.generate(rnd.nextInt(foodLabels.length), (index) => index)
                                .map((e) {
                              return Container(
                                margin: EdgeInsets.only(right: 4, top: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.black12,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4),
                                  child: Text(foodLabels[e], style: themeData.textTheme.bodyText2.copyWith(color: Colors.black54, fontSize: 12)),
                                ),
                              );
                            }).toList(),
                          ),
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
                    renderPrice(themeData,  "${rnd.nextInt(15)}.99", isRange ? "${15 + rnd.nextInt(20)}.99" : null),
                    SizedBox(height: 4),
                    Text("325 cal", style: themeData.textTheme.subtitle1),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget renderPrice(ThemeData themeData, String fromPrice, String toPrice) {
    var parts = fromPrice.split(".");
    var toParts = toPrice != null ? toPrice.split(".") : [];
    return RichText(
      text: TextSpan(
          style: themeData.textTheme.headline3.copyWith(fontSize: 18, letterSpacing: -1, fontWeight: FontWeight.w500),
          children: [
            TextSpan(text: "\$${parts[0]}", style: themeData.textTheme.headline3.copyWith(fontSize: 24)),
            TextSpan(text: ".${parts[1]}"),
            // if (toPrice != null)
            //   ...[
            //     TextSpan(text: "-"),
            //     TextSpan(text: "\$${toParts[0]}",
            //         style: themeData.textTheme.headline3.copyWith(
            //             fontSize: 18)),
            //     TextSpan(text: ".${toParts[1]}"),
            //   ]
          ]
      ),
    );
  }
}