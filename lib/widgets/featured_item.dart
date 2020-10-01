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
        width: this.width + 10,
        margin: EdgeInsets.only(right: 16),
        child: GestureDetector(
          onTap: () => print(item),
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Positioned(
                bottom: 0,
                child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: featuredItemDetails(context)
                ),
              ),
              Positioned(
                  top: 10,
                  child: MenuItemImage(imageUrl: item, width: 130, height: 130,)
              ),
            ],
          ),
        )
    );
  }

  Widget featuredItemDetails(BuildContext context) {
    var themeData = Theme.of(context);
    return Container(
      width: this.width,
      padding: EdgeInsets.only(top: 40, left: 8, right: 8),
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 15,
            offset: Offset(0, 0)
          ),
        ]
      ),
      child: Column(
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
            style: themeData.textTheme.headline4.copyWith(fontWeight: FontWeight.w800, color: Colors.black54),
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
                style: themeData.textTheme.headline4.copyWith(color: themeData.primaryColor),
              ),
              SizedBox(width: 6),
              Text("∙", style: themeData.textTheme.subtitle1),
              SizedBox(width: 6),
              Text("324 cal", style: themeData.textTheme.subtitle1,)
            ],
          ),
        ],
      ),
    );
  }
}
