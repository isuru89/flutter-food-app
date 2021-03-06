import 'package:flutter/material.dart';
import 'package:delizious/constants.dart';
import 'package:delizious/model/menu/menu_item.dart';
import 'package:delizious/model/routes/item_modal_args.dart';
import 'package:delizious/widgets/menu_item_image.dart';
import 'package:delizious/widgets/price_label.dart';

import '../extensions.dart';

class FeaturedItemList extends StatelessWidget {

  final List<MenuItem> imgList;

  FeaturedItemList({ this.imgList });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kFeaturedItemContainerHeight,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: imgList.map((MenuItem e) => InkWell(
          onTap: () {
            print(e.id);
            Navigator.pushNamed(
                context, '/item',
                arguments: ItemModalArguments(e, heroTag: 'featured-item-${e.id}')
            );
          },
          child: _FeaturedItem(
              item: e,
              width: kFeaturedItemImageWidth,
              height: kFeaturedItemImageHeight,
          ),
        )).toList(),
      ),
    );
  }

}


class _FeaturedItem extends StatelessWidget {

  final MenuItem item;
  final double width;
  final double height;

  const _FeaturedItem({Key key,
    this.item,
    this.width: kFeaturedItemImageWidth,
    this.height: kFeaturedItemImageHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Container(
        width: this.width,
        margin: EdgeInsets.only(right: kDoublePadding, bottom: kPadding, top: kPadding),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.black12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
                tag: 'featured-item-${item.id}',
                child: MenuItemImage(
                  imageUrl: item.imageUrl,
                  width: this.width,
                  height: this.height,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                )
            ),
            SizedBox(
              height: 4,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPadding),
                child: Text(
                  '${item.title}',
                  softWrap: true,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: themeData.textTheme.headline4.copyWith(fontWeight: FontWeight.w800, color: Colors.black54),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(kPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  PriceLabel(item.price, centFontSize: 14, priceFontSize: 18,),
                  Text("324 cal", style: themeData.textTheme.subtitle1,)
                ],
              ),
            ),
          ],
        )
    ).addNeumorphism(
      blurRadius: kDoublePadding,
      borderRadius: kDoublePadding,
      offset: Offset(5, 5),
      topShadowColor: Colors.white60,
      bottomShadowColor: Color(0xFF234395).withOpacity(0.05),
    );
  }

  Widget featuredItemDetails(BuildContext context, MenuItem item) {

    return Container(
      width: this.width,
      padding: EdgeInsets.only(top: 40, left: 8, right: 8),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

        ],
      ),
    );
  }
}
