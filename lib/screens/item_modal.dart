import 'package:delizious/managers/menu.dart';
import 'package:delizious/model/active_user.dart';
import 'package:delizious/model/user.dart';
import 'package:delizious/widgets/add_on_selector.dart';
import 'package:delizious/widgets/food_rating.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:delizious/widgets/food_label.dart';
import 'package:delizious/widgets/quantity_slider.dart';
import 'package:uuid/uuid.dart';
import 'package:delizious/constants.dart';
import 'package:delizious/model/cart.dart';
import 'package:delizious/model/cart_item.dart';
import 'package:delizious/model/menu/menu_item.dart';
import 'package:delizious/model/routes/item_modal_args.dart';
import 'package:delizious/widgets/icons.dart';
import 'package:delizious/widgets/image_header.dart';
import 'package:delizious/widgets/utils/app_formatter.dart';
import 'package:delizious/extensions.dart';
import 'package:provider/provider.dart';

var uuid = Uuid();

class ItemModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ItemModalArguments args = ModalRoute.of(context).settings.arguments;
    final MenuItem menuItem =
        args.cartItem != null ? args.cartItem.menuItem : args.menuItem;
    return ItemModalView(cartItem: args.cartItem, menuItem: menuItem);
  }
}

class ItemModalView extends StatefulWidget {
  final CartItem cartItem;
  final MenuItem menuItem;
  final String heroTag;

  const ItemModalView({Key key, this.cartItem, this.menuItem, this.heroTag})
      : super(key: key);

  @override
  _ItemModalState createState() {
    return _ItemModalState(this.cartItem, this.menuItem, this.heroTag);
  }
}

class _ItemModalState extends State<ItemModalView> {
  final CartItem cartItem;
  final MenuItem menuItem;
  final String heroTag;

  int quantity;
  double itemPrice;
  Map<String, List<String>> selectedAddOns;
  bool canAddToCard = true;

  _ItemModalState(this.cartItem, this.menuItem, this.heroTag);

  @override
  void initState() {
    super.initState();

    this.selectedAddOns = this.cartItem != null ? this.cartItem.addOns : Map();
    this.quantity = this.cartItem != null ? this.cartItem.quantity : 1;
    this.itemPrice = this.quantity * this.menuItem.price;
    this.canAddToCard = _checkCanAddToCart(this.menuItem);
  }

  bool _checkCanAddToCart(MenuItem item) {
    if (item.addOnGroups != null) {
      return item.addOnGroups
              .where((ag) => ag.minPermitted > 0)
              .where((ag) =>
                  !selectedAddOns.containsKey(ag.id) ||
                  selectedAddOns[ag.id].length < ag.minPermitted)
              .length ==
          0;
    }
    return true;
  }

  double _calculatePrice(int quantity, MenuItem item) {
    return quantity * item.price;
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    bool addMode = this.cartItem == null;
    return Consumer<ActiveUser>(
      builder: (context, user, child) => Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
                pinned: true,
                delegate: HeaderWithImage(
                  heroTag: this.heroTag ?? "menu-item-" + menuItem.id,
                  heroImage: menuItem.imageUrl,
                  maxHeight: kItemModalHeroImageMaxHeight,
                  minHeight: kItemModalHeroImageMinHeight,
                  embossPanelOffset: -kDoublePadding * 2,
                  embossedPanel: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Align(
                      alignment: Alignment.center,
                      child: Card(
                        shape: StadiumBorder(),
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
                                    menuItem.title,
                                    style: themeData.textTheme.headline3
                                        .copyWith(
                                            color: themeData.primaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                    textAlign: TextAlign.center,
                                    softWrap: true,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ).addNeumorphism(
                            blurRadius: 15,
                            borderRadius: 15,
                            offset: Offset(5, 5),
                            topShadowColor: Colors.white60,
                            bottomShadowColor:
                                themeData.backgroundColor.withOpacity(0.15),
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
                                  Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                  ),
                                  24),
                            ),
                            IconButton(
                                onPressed: () {
                                  if (!user.isMarkedAsFavourite(menuItem.id)) {
                                    user.addToFavourite(FavouriteItem(
                                        itemId: menuItem.id,
                                        restaurantId: menuItem.id));
                                  } else {
                                    user.removeFromFavourite(
                                        menuItem.id, menuItem.id);
                                  }
                                },
                                icon: Icon(
                                  user.isMarkedAsFavourite(menuItem.id)
                                      ? Icons.favorite
                                      : Icons.favorite_outline_rounded,
                                  color: kPrimaryColor,
                                )),
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
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          padding: const EdgeInsets.only(bottom: kPadding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              if (menuItem.prepTime > 0)
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Icon(Icons.timer),
                                    ),
                                    Text("${menuItem.prepTime} mins"),
                                  ],
                                ),
                              FoodRating(
                                menuItem.rating / 10,
                                size: 14,
                              ),
                              if (menuItem.hasCalories)
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Icon(Icons.food_bank),
                                    ),
                                    Text("${menuItem.calories ?? 0} cal"),
                                  ],
                                ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                child: Labels.createFoodLabels(
                                    menuItem.itemAttributes.dietaryLabels ??
                                        []),
                              ),
                              SizedBox(
                                width: 128,
                                child: QuantitySlider(this.quantity, () {
                                  int nxQuantity = quantity + 1;
                                  setState(() {
                                    quantity = nxQuantity;
                                    itemPrice =
                                        _calculatePrice(nxQuantity, menuItem);
                                  });
                                },
                                    quantity < 2
                                        ? null
                                        : () {
                                            int nxQuantity = quantity - 1;
                                            setState(() {
                                              quantity = nxQuantity;
                                              itemPrice = _calculatePrice(
                                                  nxQuantity, menuItem);
                                            });
                                          }),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: kPadding,
                        ),
                        Text(menuItem.description,
                            textAlign: TextAlign.justify,
                            style: TextStyle(height: 1.5, fontSize: 12)),
                        Divider(height: kDoublePadding),
                        _buildAddOnGroups(themeData, menuItem, this.cartItem),
                        if (menuItem.canAddItemInstructions != null &&
                            menuItem.canAddItemInstructions) ...[
                          Text("Instructions for Kitchen",
                              style: themeData.textTheme.headline4
                                  .copyWith(fontSize: 18)),
                          SizedBox(height: kPadding),
                          TextField(
                            autofocus: false,
                            maxLength: 100,
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: themeData.primaryColor),
                                  borderRadius:
                                      BorderRadius.circular(kDoublePadding),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0.5,
                                      color: themeData.primaryColor),
                                  borderRadius:
                                      BorderRadius.circular(kDoublePadding),
                                ),
                                hintText:
                                    'Tell something to kitchen when preparing this'),
                          )
                        ]
                      ])),
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
                      onPressed: _checkCanAddToCart(menuItem)
                          ? () {
                              var cartRef =
                                  Provider.of<Cart>(context, listen: false);
                              if (addMode) {
                                cartRef.addItem(CartItem(
                                    uuid.v4(), menuItem, quantity,
                                    addOns: this.selectedAddOns));
                              } else {
                                cartItem.addOns = this.selectedAddOns;
                                cartItem.quantity = this.quantity ?? 1;
                                cartRef.updateItem(cartItem);
                              }
                              Navigator.of(context).pop();
                            }
                          : null,
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
      ),
    );
  }

  Widget _buildAddOnGroups(
      ThemeData themeData, MenuItem menuItem, CartItem cartItem) {
    if (menuItem.addOnGroups == null || menuItem.addOnGroups.length == 0) {
      return Container();
    }

    List<Widget> allWidgets = [
      Text("Add-ons",
          style: themeData.textTheme.headline4.copyWith(fontSize: 18))
    ];

    menuItem.addOnGroups.forEach((addOnGroup) {
      if (isSingleChoiceAddOnGroup(addOnGroup)) {
        var selectedAddOn;
        if (selectedAddOns.containsKey(addOnGroup.id)) {
          var tmp =
              filterAddOnFromGroup(addOnGroup, selectedAddOns[addOnGroup.id]);
          if (tmp.length > 0) {
            selectedAddOn = tmp[0];
          }
        }
        allWidgets.add(SingleItemAddOnSelector(addOnGroup, (addon) {
          var tmp = {...selectedAddOns};
          tmp[addOnGroup.id] = [addon.id];
          this.setState(() {
            selectedAddOns = tmp;
          });
        }, selectedAddOn: selectedAddOn));
      } else {
        var selAddOns;
        if (this.selectedAddOns.containsKey(addOnGroup.id)) {
          selAddOns = filterAddOnFromGroup(
              addOnGroup, this.selectedAddOns[addOnGroup.id]);
        }
        allWidgets.add(MultiItemAddOnSelector(addOnGroup, (addons) {
          var tmp = {...this.selectedAddOns};
          tmp[addOnGroup.id] = addons.map((ao) => ao.id).toList();
          this.setState(() {
            selectedAddOns = tmp;
          });
        }, selectedAddOns: selAddOns));
      }
    });
    allWidgets.add(Divider(height: kDoublePadding));

    return Column(children: allWidgets);
  }

  List<ItemAddOn> filterAddOnFromGroup(
      ItemAddOnGroup addOnGroup, List<String> addOnIds) {
    return addOnGroup.addOns.where((it) => addOnIds.contains(it.id)).toList();
  }
}
