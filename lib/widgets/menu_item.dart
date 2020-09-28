import 'dart:math';

import 'package:flutter/material.dart';
import 'package:food_app/widgets/menu_item_image.dart';
import 'package:food_app/widgets/restaurant_header.dart';

final rnd = Random(12345);

class MenuItemWidget extends StatelessWidget {

  final Song song;
  final Function(Song) onClicked;

  const MenuItemWidget({Key key, this.song, this.onClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Container(
      height: 120,
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MenuItemImage(imageUrl: 'https://picsum.photos/300/300', isSoldOut: rnd.nextInt(5) % 2 == 0, width: 100, height: 100,),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '\$23.99',
                      style: themeData.textTheme.bodyText1.copyWith(fontSize: 16),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '512 cal',
                      style: themeData.textTheme.subtitle1
                    ),
                  ],
                ),
              ],
            ),
          ),
          // IconButton(
          //   onPressed: () => null,
          //   icon: Icon(
          //     Icons.keyboard_arrow_right,
          //     color: Colors.pinkAccent,
          //   ),
          // )
        ],
      ),
    );
  }

}