import 'package:flutter/material.dart';
import 'package:food_app/widgets/menu_item_image.dart';
import 'package:food_app/widgets/utils/gradients.dart';

class FeaturedItemList extends StatelessWidget {

  final List<String> imgList;

  FeaturedItemList({ this.imgList });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: imgList.map((String e) => _FeaturedItem(item: e, width: 150)).toList(),
      ),
    );
  }

}


class _FeaturedItem extends StatelessWidget {

  final String item;
  final double width;
  final double height;

  const _FeaturedItem({Key key, this.item, this.width: 150, this.height: 150}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(right: 10),
        child: Container(
          width: width,
          child: Column(
            children: [
              Stack(
                children: <Widget>[
                  MenuItemImage(imageUrl: item, width: 160, height: 160,)
                ],
              ),
              Padding(
                  padding: const EdgeInsets.all(0),
                  child: featuredItemDetails(context)
              )
            ],
          ),
        )
    );
  }

  Widget featuredItemDetails(BuildContext context) {
    var themeData = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 4,
        ),
        Text(
          "Fruit salad with chicken mustards and garlic also cheese",
          softWrap: true,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: themeData.textTheme.headline5.copyWith(fontWeight: FontWeight.w800),
        ),
        SizedBox(
          height: 4,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              "\$12.99",
              style: themeData.textTheme.headline5,
            ),
            SizedBox(width: 6),
            Text("∙", style: themeData.textTheme.subtitle1),
            SizedBox(width: 6),
            Text("324 cal", style: themeData.textTheme.subtitle1,)
          ],
        ),
      ],
    );
  }
}
