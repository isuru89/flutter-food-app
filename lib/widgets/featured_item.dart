import 'package:flutter/material.dart';
import 'package:food_app/model/menu.dart';
import 'package:food_app/model/routes/item_modal_args.dart';
import 'package:food_app/widgets/menu_item_image.dart';

class FeaturedItemList extends StatelessWidget {

  final List<MenuItem> imgList;

  FeaturedItemList({ this.imgList });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: imgList.map((MenuItem e) => _FeaturedItem(item: e, width: 150)).toList(),
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
    this.width: 150,
    this.height: 150,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: this.width,
        margin: EdgeInsets.only(right: 16),
        child: GestureDetector(
          onTap: () {
            print(item.id);
            Navigator.pushNamed(
                context, '/item',
                arguments: ItemModalArguments(item, heroTag: 'featured-item-${item.id}')
            );
          },
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Positioned(
                child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: featuredItemDetails(context, item)
                ),
              ),
              Positioned(
                  child: Hero(
                    tag: 'featured-item-${item.id}',
                    child: MenuItemImage(
                      imageUrl: item.images["lg"],
                      width: this.width,
                      height: 140,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                    )
                  )
              ),
            ],
          ),
        )
    );
  }

  Widget featuredItemDetails(BuildContext context, MenuItem item) {
    var themeData = Theme.of(context);
    return Container(
      width: this.width,
      padding: EdgeInsets.only(top: 40, left: 8, right: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: Colors.black12),
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
            '${item.name} ${item.name} ${item.name}',
            softWrap: true,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: themeData.textTheme.headline4.copyWith(fontWeight: FontWeight.w800, color: Colors.black54),
          ),
          SizedBox(
            height: 12,
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
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
