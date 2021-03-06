import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:delizious/constants.dart';
import 'package:delizious/model/restaurant.dart';
import 'package:delizious/widgets/icons.dart';
import 'package:delizious/widgets/restaurant_info.dart';

import '../extensions.dart';

class RestaurantHeader extends SliverPersistentHeaderDelegate {
  final Restaurant restaurant;
  final double expandedHeight;
  final bool showLogo;
  final Color logoBackgroundColor;
  final bool transparentLogo;

  RestaurantHeader({
    @required this.restaurant,
    @required this.expandedHeight,
    this.showLogo = kRestaurantHeaderShowLogo,
    this.logoBackgroundColor = kRestaurantHeaderLogoColor,
    this.transparentLogo = kRestaurantHeaderTransparentLogo
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final ratio = shrinkOffset / expandedHeight;
    var logoSize = kRestaurantHeaderLogoMinSize + ((kRestaurantHeaderLogoMaxSize - kRestaurantHeaderLogoMinSize) * (1-ratio));
    var collapsed = ratio > 0.5;
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        ClipRRect(
          child: Image.network(
            restaurant.bannerUrl,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: (showLogo && !transparentLogo) ? -10 : 0,
          left: 10,
          child: SafeArea(
            top: true,
            bottom: false,
            child: Container(
              width: MediaQuery.of(context).size.width - 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (showLogo) Card(
                          color: transparentLogo ? Colors.transparent : logoBackgroundColor,
                          child: SizedBox(
                            height: logoSize,
                            width: logoSize,
                            child: FlutterLogo(),
                          ),
                        ).addNeumorphism(
                          blurRadius: 15,
                          borderRadius: 15,
                          offset: Offset(5, 5),
                          topShadowColor: Colors.white60,
                          bottomShadowColor: Color(0xFF234395).withOpacity(0.15),
                        ),
                        SizedBox(width: 4),
                        Flexible(
                          child: Container(
                            height: logoSize,
                            padding: EdgeInsets.only(bottom: kPadding),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  this.restaurant.name,
                                  softWrap: true,
                                  maxLines: collapsed ? 1 : 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: kRestaurantHeaderFontSize,
                                      shadows: [
                                        Shadow(
                                          offset: const Offset(0.0, 0.0),
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
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: kPadding / 2),
                    child: IconButton(
                        onPressed: () {
                          showModalBottomSheet(context: context,
                          builder: (context) => RestaurantInfo(restaurant: this.restaurant,));
                        },
                        icon: IconUtils.createShadowIcon(Icon(Icons.info_outlined, color: Colors.white), 24)
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kRestaurantHeaderMinHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}