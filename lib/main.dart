// This sample shows adding an action to an [AppBar] that opens a shopping cart.
import 'package:flutter/material.dart';
import 'package:food_app/model/menu.dart';
import 'package:food_app/screens/cart_panel.dart';
import 'package:food_app/screens/checkout_screen.dart';
import 'package:food_app/screens/item_modal.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'widgets/featured_item.dart';
import 'widgets/restaurant_header.dart';
import 'widgets/app_header.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'constants.dart';
void main() => runApp(MyApp());
final List<MenuItem> imgList = [
  for (var i = 0; i < 10; i++) MenuItem(i.toString(), "Item $i", images: { "lg": "https://picsum.photos/700/400?t=$i" })
];

class Pair {
  final String name;
  final double height;

  const Pair({ this.name, this.height: 300 });
}

final List<Pair> pairs = [
  Pair(name: "Category 1"),
  Pair(name: "Category 2"),
  Pair(name: "Category 3"),
  Pair(name: "Category 4"),
  Pair(name: "Category 5"),
  Pair(name: "Category 6"),
  Pair(name: "Category 7"),
  Pair(name: "Category 8"),
];

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/item': (_) => ItemModal(),
        '/cart': (_) => CartPanel(),
        '/checkout': (_) => CheckoutPage()
      },
      title: 'Flutter Code Sample for material.AppBar.actions',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        primaryColor: kPrimaryColor,
        dividerColor: kPrimaryColor,
        accentColor: kPrimaryColor.shade800,
        errorColor: kErrorColor,
        textTheme: TextTheme(
          headline3: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: kPrimaryColor),
          headline4: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          headline5: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          headline6: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
          subtitle1: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
          subtitle2: TextStyle(fontSize: 10, fontWeight: FontWeight.w200),
        )
      ),
      home: MyStatelessWidget(),
    );
  }
}
final int bull = 0x2022;

class FoodCategoryList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FoodCategoryView();
  }

}

class FoodCategoryView extends State<FoodCategoryList> {

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemScrollController catNavScrollController = ItemScrollController();
  final ItemPositionsListener catNavPositionListener = ItemPositionsListener.create();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  int currentIndex = 0;
  Set<int> visibleCategories = Set();

  FoodCategoryView();

  void scrollTo(int index) {
    if (currentIndex != index) {
      this.setState(() {
        currentIndex = index;
      });
      itemScrollController.scrollTo(index: index, duration: Duration(milliseconds: 100));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
          children: [
            Container(
              height: 40,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: ValueListenableBuilder<Iterable<ItemPosition>>(
                valueListenable: itemPositionsListener.itemPositions,
                builder: (ctx, positions, child) {
                  int min;
                  ItemPosition minPos;
                  if (positions.isNotEmpty) {
                    minPos = positions
                        .where((element) => element.itemTrailingEdge > 0)
                        .reduce((value, element) =>
                    element.itemTrailingEdge < value.itemTrailingEdge
                        ? element
                        : value);
                    min = minPos.index;
                  }
                  if (catNavPositionListener.itemPositions.value.length > 0 && !catNavPositionListener.itemPositions.value
                      .any((element) => min == element.index && element.itemLeadingEdge > 0 && element.itemLeadingEdge < 1)) {
                    catNavScrollController.scrollTo(
                        index: min, duration: Duration(milliseconds: 100));
                  }

                  return ScrollablePositionedList.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: pairs.length,
                    itemScrollController: catNavScrollController,
                    itemPositionsListener: catNavPositionListener,
                    itemBuilder: (ctx, index) {
                      var tstyle = min == index ? TextStyle(color: Colors.red) : TextStyle();
                      return GestureDetector(
                        key: ValueKey('Scroll$index'),
                        onTap: () { print("clicked $index"); scrollTo(index); },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(child: Text(pairs[index].name, style: tstyle,),),
                        ),
                      );
                    },
                  );

                },
              ),
            ),
            Expanded(
              child: ScrollablePositionedList.builder(
                itemCount: pairs.length,
                itemBuilder: (ctx, index) {
                  if (index == 0) {
                    return FeaturedItemList(imgList: imgList);
                  } else {
                    return Container(height: 300, child: Text(pairs[index].name));
                  }
                } ,
                itemScrollController: itemScrollController,
                itemPositionsListener: itemPositionsListener,
              ),
            ),
          ],
        ),
    );
  }

}



class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(
      body: Sample3(),
    );
  }

  // Widget _slidingScaffold(ThemeData themeData) {
  //   return Scaffold(
  //       body: SlidingUpPanel(
  //         minHeight: 60,
  //         backdropEnabled: true,
  //         margin: EdgeInsets.only(left: 5, right: 5),
  //         boxShadow: [BoxShadow(
  //             color: Colors.black54,
  //             blurRadius: 20,
  //             offset: Offset(0, 0)
  //         )],
  //         borderRadius: BorderRadius.only(topRight: Radius.circular(60), topLeft: Radius.circular(60)),
  //         collapsed: Container(
  //           height: 100,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.only(topRight: Radius.circular(60), topLeft: Radius.circular(60)),
  //             color: themeData.primaryColor,
  //           ),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
  //             children: [
  //               Center(child: IconButton(icon: Icon(Icons.shopping_cart, size: 32,))),
  //               Container(
  //                 padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  //                 decoration: BoxDecoration(
  //                     color: themeData.accentColor,
  //                     borderRadius: BorderRadius.circular(10),
  //                     boxShadow: [
  //                       BoxShadow(
  //                           blurRadius: 3,
  //                           color: themeData.primaryColor,
  //                           offset: Offset(0, 0),
  //                           spreadRadius: 1
  //                       )
  //                     ]
  //                 ),
  //                 child: Text(
  //                     "\$123.27",
  //                     style: themeData.textTheme.headline3.copyWith(color: Colors.white)
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         panelBuilder: (ScrollController sc) => createCartPanel(sc),
  //         body: Sample3(),
  //       )
  //   );
  // }
}
