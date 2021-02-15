import 'package:flutter/material.dart';
import 'package:delizious/constants.dart';
import 'package:delizious/model/menu/menu_item.dart';

import 'package:smart_select/smart_select.dart';
import 'utils/app_formatter.dart';

class SingleItemAddOnSelector extends StatefulWidget {
  final ItemAddOnGroup addOnGroup;
  final Function(ItemAddOn) onAddOnSelected;
  final ItemAddOn selectedAddOn;

  SingleItemAddOnSelector(this.addOnGroup, this.onAddOnSelected,
      {Key key, this.selectedAddOn})
      : super(key: key);

  @override
  _SingleItemAddOnSelectorState createState() =>
      _SingleItemAddOnSelectorState(addOnGroup, onAddOnSelected,
          selectedAddOn: selectedAddOn);
}

class _SingleItemAddOnSelectorState extends State<SingleItemAddOnSelector> {
  final ItemAddOnGroup addOnGroup;
  final Function(ItemAddOn) onAddOnSelected;
  ItemAddOn selectedAddOn;

  _SingleItemAddOnSelectorState(this.addOnGroup, this.onAddOnSelected,
      {this.selectedAddOn});

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Container(
      child: SmartSelect<ItemAddOn>.single(
          tileBuilder: (ctx, value) {
            return S2Tile(
              padding: EdgeInsets.zero,
              title: this.addOnGroup.minPermitted > 0
                  ? RichText(
                      text: TextSpan(
                      children: [
                        TextSpan(text: addOnGroup.title,
                            style: themeData.textTheme.bodyText2),
                        TextSpan(text:
                          "  *",
                          style: themeData.textTheme.bodyText1
                              .apply(color: Colors.red),
                        ),
                      ],
                    ))
                  : Text(addOnGroup.title),
              onTap: value.showModal,
              value: value.valueDisplay,
            );
          },
          modalType: S2ModalType.bottomSheet,
          modalHeaderStyle:
              S2ModalHeaderStyle(textStyle: themeData.textTheme.headline4),
          modalHeaderBuilder: (ctx, state) {
            return Container(
              padding: const EdgeInsets.all(kPadding),
              height: kToolbarHeight * 1.2,
              color: kPrimaryColor,
              child: Row(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Text(
                      addOnGroup.title,
                      style: TextStyle(color: kOnPrimaryColor),
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          },
          value: selectedAddOn,
          title: addOnGroup.title + "xxx",
          placeholder: 'Select one',
          onChange: (state) {
            this.setState(() {
              selectedAddOn = state.value;
            });
            this.onAddOnSelected(state.value);
          },
          choiceItems: addOnGroup.addOns
              .map((e) => S2Choice(
                  value: e,
                  title: e.title,
                  subtitle: "+ \$${formatPrice(e.price)}"))
              .toList()),
    );
  }
}

class MultiItemAddOnSelector extends StatefulWidget {
  final ItemAddOnGroup addOnGroup;
  final Function(List<ItemAddOn>) onAddOnsSelected;
  final List<ItemAddOn> selectedAddOns;

  MultiItemAddOnSelector(this.addOnGroup, this.onAddOnsSelected,
      {Key key, this.selectedAddOns})
      : super(key: key);

  @override
  _MultiItemAddOnSelectorState createState() => _MultiItemAddOnSelectorState(
      addOnGroup, onAddOnsSelected, this.selectedAddOns);
}

class _MultiItemAddOnSelectorState extends State<MultiItemAddOnSelector> {
  final ItemAddOnGroup addOnGroup;
  final Function(List<ItemAddOn>) onAddOnsSelected;
  List<ItemAddOn> selectedAddOns;

  _MultiItemAddOnSelectorState(
      this.addOnGroup, this.onAddOnsSelected, this.selectedAddOns);

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Container(
      child: SmartSelect<ItemAddOn>.multiple(
          tileBuilder: (ctx, value) {
            return S2Tile(
              padding: EdgeInsets.zero,
              title: this.addOnGroup.minPermitted > 0
                  ? RichText(
                      text: TextSpan(
                      children: [
                        TextSpan(text: addOnGroup.title,
                            style: themeData.textTheme.bodyText2),
                        TextSpan(text:
                          "  *",
                          style: themeData.textTheme.bodyText1
                              .apply(color: Colors.red),
                        ),
                      ],
                    ))
                  : Text(addOnGroup.title),
              onTap: value.showModal,
              value: value.valueDisplay,
            );
          },
          modalType: S2ModalType.bottomSheet,
          modalHeaderStyle:
              S2ModalHeaderStyle(textStyle: themeData.textTheme.headline4),
          modalValidation: (state) {
            if (state.length < addOnGroup.minPermitted) {
              return 'Select at least ${addOnGroup.minPermitted}';
            } else if (state.length > addOnGroup.maxPermitted) {
              return 'Select only ${addOnGroup.maxPermitted}';
            }
            return null;
          },
          modalHeaderBuilder: (ctx, state) {
            return Container(
              padding: const EdgeInsets.all(kPadding),
              height: kToolbarHeight * 1.2,
              color: kPrimaryColor,
              child: Row(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          addOnGroup.title,
                          style: TextStyle(color: kOnPrimaryColor),
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          _deriveRequirementText(addOnGroup) +
                              " (${addOnGroup.addOns.length} available)",
                          style: themeData.textTheme.subtitle2
                              .copyWith(color: kOnPrimaryColor),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  Visibility(
                    visible: false, // !state.changes.valid,
                    child: Text(
                      state.changes?.error ?? '',
                      style: TextStyle(color: kErrorColor),
                    ),
                  ),
                  Visibility(
                      visible: state.changes.valid,
                      child: FlatButton.icon(
                        padding: EdgeInsets.zero,
                        shape: StadiumBorder(),
                        color: Colors.white,
                        onPressed: () {
                          state.closeModal(confirmed: true);
                        },
                        icon: Icon(Icons.check),
                        textColor: kPrimaryColor,
                        label: Text('Add'),
                      )),
                ],
              ),
            );
          },
          modalConfirm: true,
          value: selectedAddOns,
          title: addOnGroup.title,
          placeholder: 'Select one',
          modalFilter: true,
          onChange: (state) {
            this.setState(() {
              selectedAddOns = state.value;
            });
            this.onAddOnsSelected(state.value);
          },
          choiceItems: addOnGroup.addOns
              .map((e) => S2Choice(
                  value: e, title: e.title, subtitle: "\$${formatPrice(e.price)}"))
              .toList()),
    );
  }

  String _deriveRequirementText(ItemAddOnGroup addOnGroup) {
    if (addOnGroup.minPermitted > 0) {
      return 'Select at least ${addOnGroup.minPermitted}';
    } else {
      return 'Select up to ${addOnGroup.maxPermitted}';
    }
  }
}
