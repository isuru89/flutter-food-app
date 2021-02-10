import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constants.dart';
import 'package:food_app/model/view/bottom_panel.dart';

class RestaurantBottomPanel extends StatefulWidget {

  final List<BottomPanelItem> items;
  final Function(BottomPanelItem, int) onItemClicked;

  RestaurantBottomPanel(this.items, this.onItemClicked, {Key key}) : super(key: key);

  @override
  _RestaurantBottomPanelState createState() => _RestaurantBottomPanelState(this.items, this.onItemClicked);
}

class _RestaurantBottomPanelState extends State<RestaurantBottomPanel>
    with SingleTickerProviderStateMixin {

  final List<BottomPanelItem> items;
  final Function(BottomPanelItem, int) onItemClicked;
  int _selIndex = 0;
  AnimationController _animationController;
  Animation<double> animation;
  CurvedAnimation curve;

  _RestaurantBottomPanelState(this.items, this.onItemClicked);

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);

    Future.delayed(
      Duration(seconds: 1),
      () => _animationController.forward(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Container(
      color: Colors.transparent,
      child: AnimatedBottomNavigationBar(
        icons: items.map((e) => e.icon).toList(),
        backgroundColor: themeData.backgroundColor,
        inactiveColor: Colors.grey,
        splashColor: themeData.primaryColor,
        activeColor: themeData.primaryColor,
        activeIndex: _selIndex,
        elevation: kPadding,
        gapLocation: GapLocation.center,
        notchAndCornersAnimation: animation,
        leftCornerRadius: kDoublePadding * 2,
        rightCornerRadius: kDoublePadding * 2,
        onTap: (idx) => this.setState(() {
          _selIndex = idx;
          this.onItemClicked(items[idx], idx);
        }),
      ),
    );
  }
}
