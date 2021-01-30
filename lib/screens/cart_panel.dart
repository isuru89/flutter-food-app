
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:food_app/constants.dart';
import 'package:food_app/model/cart.dart';
import 'package:food_app/model/cart_item.dart';
import 'package:food_app/model/routes/item_modal_args.dart';
import 'package:food_app/widgets/menu_item_image.dart';
import 'package:food_app/widgets/utils/app_formatter.dart';
import 'package:provider/provider.dart';

final List<CartItem> cartItems = [];

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
    var nav = Navigator.of(context);
    return Consumer<Cart>(
      builder: (context, cart, child) => Scaffold(
        appBar: AppBar(
          title: Row(
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              Text('Cart'),
              SizedBox(width: kPadding),
              Text('(${cart.items.length} items)',
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
                          cart.changeOrderType(sel);
                          setState(() {
                            selectedOrderType = sel;
                          });
                        },
                        groupValue: cart.orderType ?? selectedOrderType,
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
                      child: InkWell(
                        onTap: () => {
                          DatePicker.showDateTimePicker(context,
                              minTime: DateTime.now(),
                              maxTime: DateTime.now().add(Duration(days: 7)),
                              onConfirm: (date) {
                            print('changed to $date');
                            cart.setOrderReadyTime(date);
                          })
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(formatOrderReadyTime(cart.orderTime ?? DateTime.now())),
                            Icon(Icons.date_range,
                              color: kPrimaryColor,),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child:
                    ListView(padding: const EdgeInsets.all(kPadding), children: [
                  for (var i = 0; i < cart.items.length; i++)
                    createCartItem(
                        cart.items[i], i == cart.items.length - 1, themeData, cart, nav)
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
                        "\$${formatPrice(cart.subTotal)}",
                        style: themeData.textTheme.headline3
                            .copyWith(color: themeData.primaryColor),
                      ),
                    ),
                    Expanded(
                      child: SafeArea(
                          bottom: true,
                          top: false,
                          child: FlatButton.icon(
                              onPressed: cart.canCheckout() ? () => Navigator.of(context).pushNamed("/checkout") : null,
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
      ),
    );
  }

  Widget createCartItem(CartItem item, bool isLast, ThemeData themeData, Cart cartRef, NavigatorState nav) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            print("xxxx");
            nav.pushNamed('/item', arguments: ItemModalArguments(null, cartItem: item));
          },
          child: Container(
            padding: const EdgeInsets.only(left: kDoublePadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    MenuItemImage(
                        imageUrl: item.menuItem.images["lg"],
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
                          Text("\$${formatPrice(item.menuItem.price)}")
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
                        onTap: () => cartRef.increaseQuantity(item, 1),
                        child: Icon(Icons.arrow_drop_up,
                            color: themeData.primaryColor, size: 32),
                      ),
                      Text("${item.quantity}"),
                      GestureDetector(
                        onTap: () => cartRef.decreaseQuantity(item, 1),
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
        ),
        if (!isLast)
          Divider(
            color: themeData.primaryColor.withOpacity(0.5),
          ),
      ],
    );
  }
}
