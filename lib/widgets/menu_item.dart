import 'dart:math';

import 'package:flutter/material.dart';
import 'package:food_app/widgets/menu_item_image.dart';
import 'package:food_app/widgets/restaurant_header.dart';

final rnd = Random(12345);

final foodLabels = ["Milk", "Soya", "Fish", "Nuts", "Glutten", "Meat", "Halal", "Spicy"];

class MenuItemWidget extends StatelessWidget {

  static final rnd = Random(123232);

  final Song song;
  final Function(Song) onClicked;

  const MenuItemWidget({Key key, this.song, this.onClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Container(
      height: 140,
      margin: EdgeInsets.symmetric(vertical: 16),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MenuItemImage(imageUrl: 'https://picsum.photos/300/300', isSoldOut: rnd.nextInt(5) % 2 == 0, width: 124, height: 124,),
          SizedBox(width: 14),
          Flexible(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${song.title} ${song.title}',
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: themeData.textTheme.headline4.copyWith(fontWeight: FontWeight.w800),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '${song.title} ${song.title} ${song.title} ${song.title}',
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: themeData.textTheme.subtitle1,
                      ),
                    ],
                  ),
                ),
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
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(rnd.nextInt(21) % 3 == 0 ? "\$14.55 - 20.99" : "\$5.99", style: themeData.textTheme.headline3.copyWith(fontSize: 14)),
                SizedBox(height: 4),
                Text("325 cal", style: themeData.textTheme.subtitle1)
              ],
            ),
          )
        ],
      ),
    );
  }

}