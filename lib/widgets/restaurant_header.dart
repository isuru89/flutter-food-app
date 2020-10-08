import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:food_app/model/menu.dart';
import 'package:food_app/model/routes/item_modal_args.dart';
import 'package:food_app/widgets/featured_item.dart';
import 'package:food_app/widgets/menu_item.dart';
import 'package:food_app/widgets/menu_list.dart';
import 'package:food_app/widgets/category_list.dart';
import 'package:food_app/model/routes/item_modal_args.dart';

class Song {
  final String title;
  final String image;

  const Song({this.title, this.image});
}

final sessions = [
  Menu(name: "Breakfast", fromTime: "07:00", endTime: "09:00"),
  Menu(name: "Lunch", fromTime: "12:00", endTime: "15:00"),
  Menu(name: "Brunch", fromTime: "15:00", endTime: "17:30"),
  Menu(name: "Dinner", fromTime: "18:30", endTime: "21:30"),
  Menu(name: "Mid-Night", fromTime: "22:00", endTime: "23:30"),
];

final categories = [
  MenuCategory("id1", "Drinks"),
  MenuCategory("id2", "Salads"),
  MenuCategory("id3", "Snacks"),
  MenuCategory("id4", "Pizzas"),
  MenuCategory("id5", "One-Whole"),
];

final List<MenuItem> imgList = [
  for (var i = 0; i < 10; i++) MenuItem(
      i.toString(),
      "Chicken Salad",
      description: "dskjdsa dkjhewd smnadsajewm dsmadksahdks anmd qmebj kknskndlsads sdadsa dsad sadsa d",
      images: { "lg": "https://picsum.photos/700/300?t=$i" })
];

final List<MenuItem> menuItemList = [
  for (var i = 0; i < 15; i++) MenuItem(
      i.toString(),
      "Chicken Salad",
      images: { "lg": "https://picsum.photos/700/400?t=$i" },
      description: "dskjdsa dkjhewd smnadsajewm dsmadksahdks anmd qmebj kknskndlsads sdadsa dsad sadsa d",
    )
];

class Sample3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var nav = Navigator.of(context);
    var themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: themeData.backgroundColor,
      // bottomNavigationBar: BottomNavigationBar(
      //   selectedItemColor: themeData.primaryColor,
      //   backgroundColor: themeData.backgroundColor,
      //   currentIndex: 4,
      //   elevation: 4,
      //   type: BottomNavigationBarType.fixed,
      //   onTap: (idx) {
      //     showModalBottomSheet(context: context, builder: (_) {
      //       return Container(
      //         height: MediaQuery.of(context).size.height / 2,
      //         child: Text("Hello bottom sheet!")
      //       );
      //     });
      //   },
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.shopping_cart),
      //       title: Text('Cart'),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.favorite),
      //       title: Text('Favorites'),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.music_note),
      //       title: Text('Songs'),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.settings_input_antenna),
      //       title: Text('Radio'),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.search),
      //       title: Text('Search'),
      //     ),
      //   ],
      // ),
      //

      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                // HeaderWidget(),
                // AlbumWidget(),
                SliverPersistentHeader(delegate: MySliverAppBar(expandedHeight: 260), pinned: true),
                SliverPersistentHeader(
                  delegate: SessionBar(
                      preferredHeight: 96,
                      marginTop: 20,
                      children: [SessionList(menuList: sessions), CategoryList(categoryList: categories)]
                  ),
                  pinned: true,
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            textBaseline: TextBaseline.alphabetic,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Featured", style: themeData.textTheme.headline3,),
                              Text("${imgList.length} items", style: themeData.textTheme.subtitle1),
                            ],
                          ),
                        ),
                        FeaturedItemList(imgList: imgList,),
                      ],
                    ),
                  ),
                ),

                // SliverToBoxAdapter(
                //   child: Padding(
                //     padding: const EdgeInsets.all(15.0),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: <Widget>[
                //         Text(
                //           'Top songs',
                //           style: TextStyle(color: Colors.white, fontSize: 17),
                //         ),
                //         Text(
                //           'ADD TO PLAYLIST',
                //           style: TextStyle(
                //               color: Colors.pinkAccent, fontSize: 13),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                SliverList(
                  delegate: SliverChildBuilderDelegate((_, index) {
                    final menuIt = menuItemList[index % menuItemList.length];
                    var widget;
                    if (index == 0) {
                      return Column(
                        children: [
                          Divider(),
                          MenuItemWidget(menuItem: menuIt, onClicked: (it) {
                            nav.pushNamed('/item', arguments: ItemModalArguments(it));
                          })
                        ],
                      );
                    } else if (index == 19) {
                      return Container(height: 60);
                    }
                    return MenuItemWidget(menuItem: menuIt, onClicked: (it) {
                      nav.pushNamed('/item', arguments: ItemModalArguments(it));
                    });
                  }, childCount: 20),
                ),
              ],
            ),
          ),
          // BottomWidget(),
        ],
      ),
    );
  }

}

class SessionBar extends SliverPersistentHeaderDelegate {

  final double preferredHeight;
  final MaterialColor bgColor;
  final List<Widget> children;
  final double marginTop;
  final bool isElevated;
  final bool isTopMost;

  SessionBar({ this.preferredHeight, this.bgColor, this.children, this.marginTop = 0,
    this.isElevated = false, this.isTopMost = true });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // final ratio = shrinkOffset / preferredHeight;
    // final stick = ratio >= 0.03;
    return ClipRect(
      child: Container(
        height: preferredHeight,
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.symmetric(horizontal: 0),
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              offset: Offset(0, 0),
              blurRadius: 10
            )
          ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [...children]
        ),
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

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      stretch: true,
      pinned: true,
      title: Text("My App"),
      backgroundColor: Color(0xFF0B0B14),
      flexibleSpace: FlexibleSpaceBar(
        // stretchModes: [
        //   StretchMode.zoomBackground,
        // ],
        background: Stack(
          fit: StackFit.expand,
          overflow: Overflow.visible,
          children: [
            Positioned.fill(
              child: Image.network(
                //'https://pbs.twimg.com/media/DbQDvwGXkAgkh5f.jpg',
                'https://source.unsplash.com/random/1600x900',
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Avicii',
                      style: Theme.of(context).textTheme.headline4.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.pinkAccent,
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  MySliverAppBar({@required this.expandedHeight});

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
          child: Image.network(
            "https://picsum.photos/1600/900",
            fit: BoxFit.cover,
          ),
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
  double get minExtent => 80;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}