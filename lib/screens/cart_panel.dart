import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:food_app/constants.dart';
import 'package:food_app/model/cart_item.dart';
import 'package:food_app/model/menu/menu_item.dart';
import 'package:food_app/widgets/menu_item_image.dart';

final List<CartItem> cartItems = [
  CartItem(
      MenuItem("1", "Item 1", images: {"lg": "https://picsum.photos/300/300"}),
      1),
  CartItem(
      MenuItem("2", "Item 2", images: {"lg": "https://picsum.photos/300/300"}),
      1),
  CartItem(
      MenuItem("3", "Item 3", images: {"lg": "https://picsum.photos/300/300"}),
      1),
  CartItem(
      MenuItem("4", "Item 4", images: {"lg": "https://picsum.photos/300/300"}),
      1),
  CartItem(
      MenuItem("5", "Item 5", images: {"lg": "https://picsum.photos/300/300"}),
      1),
  CartItem(
      MenuItem("6", "Item 6", images: {"lg": "https://picsum.photos/300/300"}),
      1),
];

class CartPanel extends StatefulWidget {
  CartPanel({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CartPanel();
  }
}

class _CartPanel extends State<CartPanel> {
  String selectedOrderType = 'pickup';

  _CartPanel();

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    print(selectedOrderType);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          textBaseline: TextBaseline.alphabetic,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            Text('Cart'),
            SizedBox(width: kPadding),
            Text('(${cartItems.length} items)',
                style: themeData.textTheme.headline4.copyWith(fontSize: 14))
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: CupertinoSegmentedControl(
                      selectedColor: themeData.primaryColor,
                      borderColor: themeData.primaryColor,
                      pressedColor: themeData.primaryColor,
                      onValueChanged: (sel) {
                        print('xxx $sel');
                        setState(() {
                          selectedOrderType = sel;
                        });
                      },
                      groupValue: selectedOrderType,
                      children: {
                        'delivery': Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: kPadding),
                          child: Text('Delivery'),
                        ),
                        'pickup': Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: kPadding),
                          child: Text('Pickup'),
                        )
                      },
                    ),
                  ),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("28nd Wed at 3.55 AM"),
                        IconButton(
                          color: themeData.primaryColor,
                          padding: EdgeInsets.zero,
                          icon: Icon(Icons.date_range),
                          onPressed: () => {
                            DatePicker.showDateTimePicker(context,
                                minTime: DateTime.now(),
                                maxTime: DateTime.now().add(Duration(days: 7)),
                                onConfirm: (date) {
                              print('changed to $date');
                            })
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child:
                  ListView(padding: const EdgeInsets.all(kPadding), children: [
                for (var i = 0; i < cartItems.length; i++)
                  createCartItem(
                      cartItems[i], i == cartItems.length - 1, themeData)
              ]),
            ),
            Container(
              height: 64,
              padding: const EdgeInsets.symmetric(horizontal: kDoublePadding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(kDoublePadding),
                    topLeft: Radius.circular(kDoublePadding)),
                boxShadow: [
                  BoxShadow(color: Colors.black87, blurRadius: kPadding)
                ],
                color: themeData.backgroundColor,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      "\$43.88",
                      style: themeData.textTheme.headline3
                          .copyWith(color: themeData.primaryColor),
                    ),
                  ),
                  Expanded(
                    child: SafeArea(
                        bottom: true,
                        top: false,
                        child: FlatButton.icon(
                            onPressed: () => Navigator.of(context).pushNamed("/checkout"),
                            icon: Text('Checkout'),
                            label: Icon(Icons.arrow_forward_ios, size: 16),
                            shape: StadiumBorder(),
                            textColor: themeData.backgroundColor,
                            color: themeData.primaryColor,
                        )
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget createCartItem(CartItem item, bool isLast, ThemeData themeData) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: kDoublePadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  MenuItemImage(
                      imageUrl: "https://picsum.photos/300/300",
                      width: 64,
                      height: 64),
                  SizedBox(
                    width: kDoublePadding,
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(child: Text("${item.menuItem.name}")),
                        SizedBox(
                          height: kPadding,
                        ),
                        Text("\$12.33")
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: 48,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => print("up"),
                      child: Icon(Icons.arrow_drop_up,
                          color: themeData.primaryColor, size: 32),
                    ),
                    Text("1"),
                    GestureDetector(
                      onTap: () => print("down"),
                      child: Icon(
                        Icons.arrow_drop_down,
                        color: themeData.primaryColor,
                        size: 32,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        if (!isLast)
          Divider(
            color: themeData.primaryColor.withOpacity(0.5),
          ),
      ],
    );
  }
}
