import 'package:flutter/material.dart';

class RestaurantHeader extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final bool showLogo;

  RestaurantHeader({@required this.expandedHeight, this.showLogo = true});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final ratio = shrinkOffset / expandedHeight;
    var logoSize = 48 + (48 * (1-ratio));
    var fontSize = 22.0;
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        ClipRRect(
          //borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40*(1-ratio)), bottomRight: Radius.circular(40*(1-ratio))),
          child: Image.network(
            "https://picsum.photos/1600/900",
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: showLogo ? -10 : 0,
          left: 10,
          child: Container(
            width: MediaQuery.of(context).size.width - 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (showLogo) Card(
                      color: Colors.white,
                      elevation: 3,
                      child: SizedBox(
                        height: logoSize,
                        width: logoSize,
                        child: FlutterLogo(),
                      ),
                    ),
                    SizedBox(width: 4),
                    Container(
                      height: logoSize,
                      padding: EdgeInsets.only(bottom: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Ocean's Side",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: fontSize,
                                shadows: [
                                  Shadow(
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 20.0,
                                    color: Color.fromARGB(128, 0, 0, 0),
                                  ),
                                ]
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () { print("clicked"); },
                    icon: Icon(Icons.phone, color: Colors.red)
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}