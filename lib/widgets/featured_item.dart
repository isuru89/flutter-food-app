import 'package:flutter/material.dart';
import 'package:food_app/constants.dart';
import 'package:food_app/model/menu/menu_item.dart';
import 'package:food_app/model/routes/item_modal_args.dart';
import 'package:food_app/widgets/menu_item_image.dart';

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
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: kPadding,
                  offset: Offset(0, 0)
              ),
            ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
                tag: 'featured-item-${item.id}',
                child: MenuItemImage(
                  imageUrl: item.images["lg"],
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
                  '${item.name}',
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
                  Text(
                    "\$12.99",
                    style: themeData.textTheme.headline4.copyWith(color: themeData.primaryColor),
                  ),
                  Text("324 cal", style: themeData.textTheme.subtitle1,)
                ],
              ),
            ),
          ],
        )
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
