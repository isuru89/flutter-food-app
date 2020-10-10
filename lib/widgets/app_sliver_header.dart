import 'package:flutter/material.dart';


class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final double minHeight;
  final Image image;

  MySliverAppBar({
    @required this.expandedHeight,
    @required this.image,
    this.minHeight = 80
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final ratio = shrinkOffset / expandedHeight;
    final stick = ratio >= 1;
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        ClipRRect(
          //borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40*(1-ratio)), bottomRight: Radius.circular(40*(1-ratio))),
          child: image,
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Ocean's Side",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 23,
                      shadows: [
                        Shadow(
                          offset: Offset(0.0, 0.0),
                          blurRadius: 20.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ]
                  ),
                ),

              ],
            ),
          ),
        ),
        // Positioned(
        //   top: expandedHeight - 96 - shrinkOffset,
        //   left: MediaQuery.of(context).size.width / 8,
        //   child: Opacity(
        //     opacity: (1 - shrinkOffset / expandedHeight),
        //     child: Card(
        //       color: Colors.transparent,
        //       elevation: 10,
        //       child: SizedBox(
        //         height: 96,
        //         width: MediaQuery.of(context).size.width / 4 * 3,
        //         child: FlutterLogo(),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}