
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:food_app/model/cart_item.dart';
import 'package:food_app/model/menu.dart';
import 'package:food_app/widgets/menu_item_image.dart';

final List<CartItem> cartItems = [
  CartItem(MenuItem("1", "Item 1", images: { "lg": "https://picsum.photos/300/300" }), 1),
  CartItem(MenuItem("2", "Item 2", images: { "lg": "https://picsum.photos/300/300" }), 1),
  CartItem(MenuItem("3", "Item 3", images: { "lg": "https://picsum.photos/300/300" }), 1),
  CartItem(MenuItem("4", "Item 4", images: { "lg": "https://picsum.photos/300/300" }), 1),
  CartItem(MenuItem("5", "Item 5", images: { "lg": "https://picsum.photos/300/300" }), 1),
  CartItem(MenuItem("6", "Item 6", images: { "lg": "https://picsum.photos/300/300" }), 1),
];

Widget createCartPanel(ScrollController sc) {
  return CartPanel(sc: sc);
}

class CartPanel extends StatefulWidget {
  final ScrollController sc;

  CartPanel({Key key, this.sc}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CartPanel(sc: sc);
  }

}

class _CartPanel extends State<CartPanel> {

  final ScrollController sc;
  String selectedOrderType = 'pickup';

  _CartPanel({ this.sc });

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    print(selectedOrderType);
    return Container(
      child: Column(
        children: [
          // Container(
          //   height: 60,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.only(topRight: Radius.circular(60), topLeft: Radius.circular(60)),
          //     color: themeData.primaryColor,
          //   ),
          //   child: Center(child: IconButton(icon: Icon(Icons.shopping_cart, size: 32))),
          // ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Flexible(
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       Text("Today at 3.55 AM"),
                //       IconButton(
                //         color: themeData.primaryColor,
                //         padding: EdgeInsets.all(0),
                //         icon: Icon(Icons.date_range),
                //         onPressed: () => {
                //           DatePicker.showDateTimePicker(context,
                //               minTime: DateTime.now(),
                //               maxTime: DateTime.now().add(Duration(days: 7)),
                //               onConfirm: (date) {
                //                 print('changed to $date');
                //               })
                //         },
                //       ),
                //     ],
                //   ),
                // ),

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
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: Text('Delivery'),
                      ),
                      'pickup': Text('Pickup')
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(left: 8),
                child: Text("${cartItems.length} Items", style: Theme.of(context).textTheme.headline3,)
              )
            ],
          ),
          Expanded(
            child: ListView(
              controller: sc,
              padding: EdgeInsets.all(8),
              children: [
                for (var i=0; i<cartItems.length; i++)
                  createCartItem(cartItems[i], i==cartItems.length-1, themeData)
              ]
            ),
          ),
          Container(
            height: 64,
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black87,
                  blurRadius: 5
                )
              ],
              color: themeData.primaryColor,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: SafeArea(
                    bottom: true,
                    top: false,
                    child: Container(
                      child: Row(
                        children: [
                          Icon(Icons.check, color: Colors.white,),
                          SizedBox(width: 8),
                          Text("Checkout",
                            style: themeData.textTheme.headline3.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                        ],
                      ),
                      ),
                    ),
                ),
                Container(
                  child: Text("\$43.88",
                    style: themeData.textTheme.headline3.copyWith(color: Colors.white),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget createCartItem(CartItem item, bool isLast, ThemeData themeData) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  MenuItemImage(imageUrl: "https://picsum.photos/300/300", width: 64, height: 64),
                  SizedBox(width: 16,),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(child: Text("${item.menuItem.name}")),
                        SizedBox(height: 8,),
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
                      child: Icon(Icons.arrow_drop_up, color: themeData.primaryColor),
                    ),
                    Text("1"),
                    GestureDetector(
                      onTap: () => print("down"),
                      child: Icon(Icons.arrow_drop_down, color: themeData.primaryColor),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        if (!isLast) Divider(color: themeData.primaryColor.withOpacity(0.5),),
      ],
    );
  }

}