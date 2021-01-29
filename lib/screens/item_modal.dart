import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/constants.dart';
import 'package:food_app/managers/menu.dart';
import 'package:food_app/model/menu/menu_item.dart';
import 'package:food_app/model/routes/item_modal_args.dart';
import 'package:food_app/widgets/add_on_selector.dart';
import 'package:food_app/widgets/icons.dart';
import 'package:food_app/widgets/image_header.dart';

final ItemAddOnGroup addOnGroup =
    ItemAddOnGroup("addon=group-1", "Toppings", 1, 1, [
  ItemAddOn("ao-g1-1", "Salads", 2.99),
  ItemAddOn("ao-g1-2", "Cherry", 1.99),
  ItemAddOn("ao-g1-3", "Pineapples", 3.99),
  ItemAddOn("ao-g1-4", "Cream", 0.99),
]);
final ItemAddOnGroup multiAddOnGroup =
    ItemAddOnGroup("addon-group-2", "Flavours", 1, 3, [
  ItemAddOn("ao-g2-1", "Chocolate", 2.99),
  ItemAddOn("ao-g2-2", "Vanilla", 1.99),
  ItemAddOn("ao-g2-3", "Strawberry", 3.99),
  ItemAddOn("ao-g2-4", "Cherry", 0.99),
  ItemAddOn("ao-g2-5", "Hazlenuts", 0.99),
]);

class ItemModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ItemModalArguments args = ModalRoute.of(context).settings.arguments;
    final MenuItem menuItem = args.menuItem;
    var themeData = Theme.of(context);
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
                  height: kDoublePadding * 4,
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
                          child: Text(
                            menuItem.name,
                            style: themeData.textTheme.headline4.copyWith(
                                color: themeData.primaryColor,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
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
                child: Column(children: [
                  Text(
                      menuItem.description,
                      textAlign: TextAlign.justify,
                      style: TextStyle(height: 1.5, fontSize: 12)),
                  Divider(height: kDoublePadding),
                  Text("Add-ons",
                      style:
                          themeData.textTheme.headline4.copyWith(fontSize: 18)),
                  if (hasAddOnGroups(menuItem) && isSingleChoiceAddOnGroup(menuItem.addOnGroups[0]))
                    SingleItemAddOnSelector(menuItem.addOnGroups[0], (addon) => print(addon))
                  else
                    MultiItemAddOnSelector(menuItem.addOnGroups[0], (addons) => print(addons)),
                  Divider(height: kDoublePadding),
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
              Text("\$824.21",
                  style: themeData.textTheme.headline3
                      .copyWith(letterSpacing: 1, color: Colors.white)),
              Row(
                children: [
                  FlatButton(
                    shape: StadiumBorder(),
                    color: Colors.white,
                    onPressed: () { Navigator.of(context).pop(); },
                    child: Text("Add to Cart",
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
}
