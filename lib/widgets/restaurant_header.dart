import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:food_app/model/cart.dart';
import 'package:food_app/model/menu/menu_item.dart';
import 'package:food_app/model/restaurant.dart';
import 'package:food_app/model/routes/item_modal_args.dart';
import 'package:food_app/widgets/featured_item.dart';
import 'package:food_app/widgets/food_label.dart';
import 'package:food_app/widgets/menu_item.dart';
import 'package:food_app/widgets/menu_list.dart';
import 'package:food_app/widgets/category_list.dart';
import 'package:food_app/widgets/restaurant_app_bar.dart';

import 'package:food_app/constants.dart';
import 'package:food_app/widgets/restaurant_bottom_panel.dart';
import 'package:provider/provider.dart';

class DeliciousFoodApp extends StatefulWidget {
  @override
  _DeliciousFoodAppState createState() =>
      _DeliciousFoodAppState("restaurant.json");
}

class _DeliciousFoodAppState extends State<DeliciousFoodApp> {
  final Random random = Random(123456);

  final String restaurantFileName;
  Future<Restaurant> _restaurant;
  String selectedSessionName;
  String selectedCategoryId;

  _DeliciousFoodAppState(this.restaurantFileName);

  @override
  void initState() {
    super.initState();
    _restaurant = this.loadRestaurant();
  }

  Future<Restaurant> loadRestaurant() async {
    var jsonStr = await rootBundle
        .loadString("assets/localdata/${this.restaurantFileName}");
    var decoded = jsonDecode(jsonStr);
    return Restaurant.fromJson(decoded);
  }

  @override
  Widget build(BuildContext context) {
    var nav = Navigator.of(context);
    var themeData = Theme.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () => nav.pushNamed('/cart'),
          child: Badge(
            badgeContent: Text(
              "${Provider.of<Cart>(context).items.length}",
              style: TextStyle(color: Colors.white),
            ),
            position: BadgePosition.topEnd(top: -20, end: -20),
            child: Icon(Icons.shopping_cart_outlined),
          ),
          backgroundColor: themeData.primaryColor),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: themeData.backgroundColor,
      extendBody: true,
      bottomNavigationBar: RestaurantBottomPanel(
        kBottomPanelItems,
        (item, _) => print('$item'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<Restaurant>(
              future: _restaurant,
              builder: (BuildContext ctx, AsyncSnapshot<Restaurant> snapshot) {
                if (snapshot.hasData) {
                  Restaurant restaurant = snapshot.data;
                  return buildRestaurantHomePage(restaurant, themeData, nav);
                }
                return Text("Loading...");
              },
            ),
          ),
          // BottomWidget(),
        ],
      ),
    );
  }

  List<MenuItem> findFeaturedItems(List<MenuItem> fullMenuItemList) {
    List<MenuItem> tmpList = []..addAll(fullMenuItemList);
    tmpList.shuffle();
    return tmpList.sublist(0, random.nextInt(fullMenuItemList.length));
  }

  CustomScrollView buildRestaurantHomePage(
      Restaurant restaurant, ThemeData themeData, NavigatorState nav) {
    var selectedMenuSession = this.selectedSessionName == null
        ? restaurant.menuSessions.firstWhere((menu) => menu.isAvailable())
        : restaurant.menuSessions
            .firstWhere((m) => m.name == this.selectedSessionName);
    var selectedCategory = this.selectedCategoryId == null
        ? selectedMenuSession.categories.values.first
        : selectedMenuSession.categories.values
            .firstWhere((cat) => cat.id == this.selectedCategoryId);
    var allItemsInCategory = selectedCategory.itemIds
        .map((itId) => selectedMenuSession.items[itId])
        .toList();
    var featuredItems = findFeaturedItems(allItemsInCategory);

    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
            delegate: RestaurantHeader(
              restaurant: restaurant,
              expandedHeight: kRestaurantHeaderHeight,
            ),
            pinned: true),
        SliverPersistentHeader(
          delegate: SessionBar(preferredHeight: kSessionBarHeight,
              // marginTop: 20,
              children: [
                MenuList(
                  menuList: restaurant.menuSessions.toList(),
                  onMenuSelected: (sessionName) {
                    this.setState(() {
                      selectedSessionName = sessionName;
                      selectedCategoryId = restaurant.menuSessions
                          .firstWhere((m) => m.name == sessionName)
                          .categories[0]
                          .id;
                    });
                  },
                ),
                CategoryList(
                  key: ValueKey(selectedMenuSession.name),
                  categoryList: selectedMenuSession.categories.values.toList(),
                  onCategoryClicked: (id) {
                    this.setState(() {
                      selectedCategoryId = id;
                    });
                  },
                ),
              ]),
          pinned: true,
        ),
        if (featuredItems.length > 0)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPadding * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Labels.createHeaderAndSummary(
                    "Featured",
                    "${featuredItems.length} items",
                    themeData,
                  ),
                  FeaturedItemList(
                    imgList: featuredItems,
                  ),
                  Divider(),
                ],
              ),
            ),
          ),
        SliverList(
          delegate: SliverChildBuilderDelegate((_, index) {
            final menuIt =
                allItemsInCategory[index % allItemsInCategory.length];
            if (index == 0) {
              return Column(
                children: [
                  MenuItemWidget(
                      menuItem: menuIt,
                      onClicked: (it) {
                        nav.pushNamed(
                          '/item',
                          arguments: ItemModalArguments(it),
                        );
                      })
                ],
              );
            } else if (index == 19) {
              return Container(height: 60);
            }
            return MenuItemWidget(
                menuItem: menuIt,
                onClicked: (it) {
                  nav.pushNamed(
                    '/item',
                    arguments: ItemModalArguments(it),
                  );
                });
          }, childCount: allItemsInCategory.length),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 64,
          ),
        )
      ],
    );
  }
}

class SessionBar extends SliverPersistentHeaderDelegate {
  final double preferredHeight;
  final MaterialColor bgColor;
  final List<Widget> children;
  final bool isElevated;
  final bool isTopMost;

  SessionBar(
      {this.preferredHeight,
      this.bgColor,
      this.children,
      this.isElevated = false,
      this.isTopMost = true});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final ratio = shrinkOffset / preferredHeight;
    final stick = ratio > 0;
    return ClipRect(
      child: Container(
        height: preferredHeight,
        margin: EdgeInsets.only(bottom: kDoublePadding),
        decoration:
            BoxDecoration(color: Theme.of(context).backgroundColor, boxShadow: [
          if (stick)
            BoxShadow(
                color: Colors.black38, offset: Offset(0, 0), blurRadius: 10)
        ]),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [...children]),
      ),
    );
  }

  @override
  double get maxExtent => preferredHeight;

  @override
  double get minExtent => preferredHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class AlbumWidget extends StatelessWidget {
  const AlbumWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Image.network(
              'https://clanfmok.com/wp-content/uploads/2019/12/unnamed.png',
              height: 90,
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fades Away (Tribute Concert Version) [feat. MishCatt] - Single',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      color: Colors.pinkAccent,
                      child: Text('ADD TO PLAYLIST'),
                      onPressed: () => null)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomWidget extends StatelessWidget {
  const BottomWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Image.network(
            'https://images.genius.com/aaedbb591aa119f91b9339bbe97f20ae.1000x998x1.png',
            height: 40,
          ),
          const SizedBox(
            width: 10,
          ),
          Text('Heaven'),
          Spacer(),
          IconButton(
            icon: Icon(
              Icons.play_arrow,
              color: Colors.white,
            ),
            onPressed: () => null,
          ),
          Align(
            widthFactor: 0.2,
            child: IconButton(
              icon: Icon(
                Icons.play_arrow,
                color: Colors.white,
              ),
              onPressed: () => null,
            ),
          ),
          Align(
            widthFactor: 0.2,
            child: IconButton(
              icon: Icon(
                Icons.play_arrow,
                color: Colors.white,
              ),
              onPressed: () => null,
            ),
          ),
        ],
      ),
    );
  }
}
