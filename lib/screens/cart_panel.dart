import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:delizious/constants.dart';
import 'package:delizious/model/cart.dart';
import 'package:delizious/model/cart_item.dart';
import 'package:delizious/model/order_types.dart';
import 'package:delizious/model/routes/item_modal_args.dart';
import 'package:delizious/widgets/menu_item_image.dart';
import 'package:delizious/widgets/utils/app_formatter.dart';
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
  OrderType selectedOrderType = OrderType.Pickup;

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
                  style: themeData.textTheme.headline4
                      .copyWith(fontSize: 14, color: themeData.backgroundColor))
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
                          OrderType.Delivery: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kPadding),
                            child: Text(OrderType.Delivery.displayText),
                          ),
                          OrderType.Pickup: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kPadding),
                            child: Text(OrderType.Pickup.displayText),
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
                            Text(formatOrderReadyTime(
                                cart.orderTime ?? DateTime.now())),
                            Icon(
                              Icons.date_range,
                              color: kPrimaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: cart.hasItems()
                    ? ListView(
                        padding: const EdgeInsets.all(kPadding),
                        children: [
                            for (var i = 0; i < cart.items.length; i++)
                              createCartItem(
                                  context,
                                  cart.items[i],
                                  i == cart.items.length - 1,
                                  themeData,
                                  cart,
                                  nav)
                          ])
                    : Align(
                        child:
                            Text("You need to add items to place an order!")),
              ),
              createBottomPanel(themeData, cart)
            ],
          ),
        ),
      ),
    );
  }

  Widget _recieptLine(String title, String value, ThemeData themeData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: themeData.textTheme.bodyText2.copyWith(fontSize: 18)),
        Text(value, style: themeData.textTheme.bodyText1.copyWith(fontSize: 18))
      ],
    );
  }

  Widget createBottomPanel(ThemeData themeData, Cart cart) {
    return Container(
      // height: 64,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(kDoublePadding),
            topLeft: Radius.circular(kDoublePadding)),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: kDoublePadding)
        ],
        color: themeData.backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: kDoublePadding, vertical: kDoublePadding),
              child: Column(
                children: [
                  _recieptLine(
                      "Subtotal", "\$${formatPrice(cart.subTotal)}", themeData),
                  if (cart.hasDiscount())
                    _recieptLine("Discount", "-\$${formatPrice(cart.discount)}",
                        themeData),
                  if (cart.orderType == OrderType.Delivery)
                    _recieptLine("Delivery Fee",
                        "\$${formatPrice(cart.deliveryFee)}", themeData),
                  if (cart.hasTax())
                    _recieptLine(
                        "Tax", "\$${formatPrice(cart.totalTax)}", themeData),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total",
                          style: themeData.textTheme.headline3
                              .copyWith(fontSize: 22)),
                      Text("\$${formatPrice(cart.grandTotal)}",
                          style: themeData.textTheme.headline3
                              .copyWith(fontSize: 22))
                    ],
                  )
                ],
              )),
          if (cart.canCheckout())
            Container(
              height: 56,
              color: kPrimaryColor,
              width: double.infinity,
              child: Align(
                alignment: Alignment.centerRight,
                child: FlatButton.icon(
                  onPressed: () => Navigator.of(context).pushNamed("/checkout"),
                  icon: Text(
                    'Pay & Checkout',
                    style: themeData.textTheme.headline3
                        .copyWith(color: themeData.backgroundColor),
                  ),
                  label: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: themeData.backgroundColor,
                  ),
                  textColor: themeData.backgroundColor,
                  color: themeData.primaryColor,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget createCartItem(BuildContext context, CartItem item, bool isLast,
      ThemeData themeData, Cart cartRef, NavigatorState nav) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            showModalBottomSheet<void>(
                context: context,
                builder: (context) {
                  return Container(
                    height: 120,
                    child: ListView(children: [
                      ListTile(
                        title: Text("Edit"),
                        leading: Icon(Icons.edit),
                        onTap: () {
                          Navigator.pop(context);
                          nav.pushNamed('/item',
                              arguments:
                                  ItemModalArguments(null, cartItem: item));
                        },
                      ),
                      ListTile(
                        title: Text("Delete"),
                        leading: Icon(Icons.delete),
                        onTap: () {
                          cartRef.removeItem(item);
                          Navigator.pop(context);
                        },
                      )
                    ]),
                  );
                });
          },
          child: Container(
            padding: const EdgeInsets.only(left: kDoublePadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    MenuItemImage(
                        imageUrl: item.menuItem.imageUrl,
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
                          Container(child: Text("${item.menuItem.title}")),
                          _printAddOnLines(item, themeData),
                          SizedBox(
                            height: kPadding,
                          ),
                          // Text("\$${formatPrice(item.menuItem.price)}")
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
                      Text("x${item.quantity}"),
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

  Widget _printAddOnLines(CartItem cartItem, ThemeData themeData) {
    if (cartItem.addOns == null || cartItem.addOns.isEmpty) {
      return Container();
    }

    return Column(
      children: cartItem.addOns.keys.map((addOnGroupName) {
        var grpName = _findAddOnGroupName(addOnGroupName, cartItem);
        var addonNames = _findAddOnNames(
                addOnGroupName, cartItem.addOns[addOnGroupName], cartItem)
            .join(", ");
        return Text(
          "   - $grpName: $addonNames",
          style: themeData.textTheme.subtitle2.copyWith(fontSize: 12),
        );
      }).toList(),
    );
  }

  String _findAddOnGroupName(String id, CartItem cartItem) {
    return null;
    // return cartItem.menuItem.addOnGroups.firstWhere((ag) => ag.id == id).name;
  }

  List<String> _findAddOnNames(
      String groupId, List<String> ids, CartItem cartItem) {
        return List();
    // return cartItem.menuItem.addOnGroups
    //     .firstWhere((ag) => ag.id == groupId)
    //     .addOns
    //     .where((ao) => ids.contains(ao.id))
    //     .map((ao) => ao.name)
    //     .toList();
  }
}
