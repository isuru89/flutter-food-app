
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/widgets/food_label.dart';
import 'package:food_app/widgets/quantity_slider.dart';
import 'package:uuid/uuid.dart';
import 'package:food_app/constants.dart';
import 'package:food_app/managers/menu.dart';
import 'package:food_app/model/cart.dart';
import 'package:food_app/model/cart_item.dart';
import 'package:food_app/model/menu/menu_item.dart';
import 'package:food_app/model/routes/item_modal_args.dart';
import 'package:food_app/widgets/add_on_selector.dart';
import 'package:food_app/widgets/icons.dart';
import 'package:food_app/widgets/image_header.dart';
import 'package:food_app/widgets/utils/app_formatter.dart';
import 'package:provider/provider.dart';

var uuid = Uuid();
class ItemModal extends StatefulWidget {
  @override
  _ItemModalState createState() => _ItemModalState();
}

class _ItemModalState extends State<ItemModal> {

  int quantity;
  double itemPrice;

  @override
  void initState() {
    super.initState();

  }

  double _calculateItemPrice(MenuItem item) {
    return item.price * (this.quantity ?? 1);
  }

  @override
  Widget build(BuildContext context) {
    final ItemModalArguments args = ModalRoute.of(context).settings.arguments;
    final MenuItem menuItem = args.cartItem != null ? args.cartItem.menuItem : args.menuItem;
    final int itemQuantity = (quantity ?? (args.cartItem != null ? args.cartItem.quantity : 1));
    final double itemPrice = itemQuantity * menuItem.price;
    var themeData = Theme.of(context);
    var cartRef = Provider.of<Cart>(context);
    bool addMode = args.cartItem == null;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
              pinned: true,
              delegate: HeaderWithImage(
                heroTag: args.heroTag ?? "menu-item-" + menuItem.id,
                heroImage: menuItem.images['lg'],
                maxHeight: kItemModalHeroImageMaxHeight,
                minHeight: kItemModalHeroImageMinHeight,
                embossPanelOffset: -kDoublePadding * 2,
                embossedPanel: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Align(
                    alignment: Alignment.center,
                    child: Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: kPadding, horizontal: kPadding),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  menuItem.name,
                                  style: themeData.textTheme.headline3.copyWith(
                                      color: themeData.primaryColor,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Expanded(
                                child: QuantitySlider(itemQuantity,
                                  () {
                                    setState(() {
                                      print(itemQuantity);
                                      quantity = (quantity ?? itemQuantity) + 1;
                                    });
                                  },
                                  itemQuantity < 2 ? null : () {
                                    setState(() {
                                      quantity = (quantity ?? itemQuantity) - 1;
                                    });
                                  }),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                actionPanel: SafeArea(
                    top: true,
                    bottom: false,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: IconUtils.createShadowIcon(
                                  Icon(Icons.arrow_back_ios,
                                      color: Colors.white),
                                  24)),
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: IconUtils.createShadowIcon(
                                  Icon(Icons.favorite_outline_rounded,
                                      color: Colors.white),
                                  24)),
                        ],
                      ),
                    )),
              )),
          SliverPersistentHeader(
            delegate: FixedHeader(kDoublePadding * 2),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kPadding, vertical: kPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  Labels.createFoodLabels(menuItem.tags ?? ["Milk", "Halal"]),
                  Container(height: kPadding,),
                  Text(
                      menuItem.description,
                      textAlign: TextAlign.justify,
                      style: TextStyle(height: 1.5, fontSize: 12)),
                  Divider(height: kDoublePadding),
                  _buildAddOnGroups(themeData, menuItem),
                  Text("Instructions for Kitchen",
                      style:
                          themeData.textTheme.headline4.copyWith(fontSize: 18)),
                  SizedBox(height: kPadding),
                  TextField(
                    autofocus: false,
                    maxLength: 100,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: themeData.primaryColor),
                          borderRadius: BorderRadius.circular(kDoublePadding),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 0.5, color: themeData.primaryColor),
                          borderRadius: BorderRadius.circular(kDoublePadding),
                        ),
                        hintText:
                            'Tell something to kitchen when preparing this'),
                  )
                ]
              )
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        bottom: true,
        child: Container(
          height: kItemModalBottomPanelHeight,
          color: themeData.primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: kDoublePadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("\$${formatPrice(itemPrice)}",
                  style: themeData.textTheme.headline3
                      .copyWith(letterSpacing: 1, color: Colors.white)),
              Row(
                children: [
                  FlatButton(
                    shape: StadiumBorder(),
                    color: Colors.white,
                    onPressed: () {
                      var cartRef = Provider.of<Cart>(context, listen: false);
                      if (addMode) {
                        cartRef.addItem(CartItem(uuid.v4(), menuItem, itemQuantity));
                      } else {
                        args.cartItem.quantity = this.quantity ?? 1;
                        cartRef.updateItem(args.cartItem);
                      }
                      Navigator.of(context).pop();
                    },
                    child: Text(addMode ? "Add to Cart" : "Update",
                        style: themeData.textTheme.headline3.copyWith(
                            color: themeData.primaryColor, fontSize: 18)),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddOnGroups(ThemeData themeData, MenuItem menuItem) {
    if (menuItem.addOnGroups == null || menuItem.addOnGroups.length == 0) {
      return Container();
    }

    List<Widget> allWidgets = [
      Text("Add-ons", style: themeData.textTheme.headline4.copyWith(fontSize: 18))
    ];

    menuItem.addOnGroups.forEach((addOnGroup) => {
        if (isSingleChoiceAddOnGroup(addOnGroup))
          allWidgets.add(SingleItemAddOnSelector(addOnGroup, (addon) => print(addon)))
        else
          allWidgets.add(MultiItemAddOnSelector(addOnGroup, (addons) => print(addons)))
    });
    allWidgets.add(Divider(height: kDoublePadding));

    return Column(
      children: allWidgets
    );
  }
}
