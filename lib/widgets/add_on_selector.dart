import 'package:flutter/material.dart';
import 'package:delizious/constants.dart';
import 'package:delizious/model/menu/menu_item.dart';

import 'package:smart_select/smart_select.dart';
import 'utils/app_formatter.dart';

class SingleItemAddOnSelector extends StatefulWidget {
  final ItemAddOnGroup addOnGroup;
  final Function(ItemAddOn) onAddOnSelected;
  final ItemAddOn selectedAddOn;

  SingleItemAddOnSelector(this.addOnGroup, this.onAddOnSelected, {Key key, this.selectedAddOn}) : super(key: key);

  @override
  _SingleItemAddOnSelectorState createState() => _SingleItemAddOnSelectorState(addOnGroup, onAddOnSelected, selectedAddOn: selectedAddOn);
}

class _SingleItemAddOnSelectorState extends State<SingleItemAddOnSelector> {

  final ItemAddOnGroup addOnGroup;
  final Function(ItemAddOn) onAddOnSelected;
  ItemAddOn selectedAddOn;

  _SingleItemAddOnSelectorState(this.addOnGroup, this.onAddOnSelected, { this.selectedAddOn });

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Container(
      child: SmartSelect<ItemAddOn>.single(
        tileBuilder: (ctx, value) {
          return S2Tile(
            padding: EdgeInsets.zero,
            title: this.addOnGroup.minItems > 0 ?
              Row(children: [
                Text(addOnGroup.name, style: themeData.textTheme.bodyText2),
                Text("  *", style: themeData.textTheme.bodyText1.apply(color: Colors.red),),
                ],
              ) :
             Text(addOnGroup.name),
            onTap: value.showModal,
            value: value.valueDisplay,
          );
        },
        modalType: S2ModalType.bottomSheet,
        modalHeaderStyle:
            S2ModalHeaderStyle(textStyle: themeData.textTheme.headline4),
        value: selectedAddOn,
        title: addOnGroup.name,
        placeholder: 'Select one',
        onChange: (state) {
          this.setState(() {
            selectedAddOn = state.value;
          });
          this.onAddOnSelected(state.value);
        },
        choiceItems: addOnGroup.addOns.map((e) => S2Choice(
          value: e,
          title: e.name,
          subtitle: "+ \$${formatPrice(e.price)}"
        )).toList()
      ),
    );
  }
}


class MultiItemAddOnSelector extends StatefulWidget {
  final ItemAddOnGroup addOnGroup;
  final Function(List<ItemAddOn>) onAddOnsSelected;
  final List<ItemAddOn> selectedAddOns;

  MultiItemAddOnSelector(this.addOnGroup, this.onAddOnsSelected, {Key key, this.selectedAddOns}) : super(key: key);

  @override
  _MultiItemAddOnSelectorState createState() => _MultiItemAddOnSelectorState(addOnGroup, onAddOnsSelected, this.selectedAddOns);
}

class _MultiItemAddOnSelectorState extends State<MultiItemAddOnSelector> {

  final ItemAddOnGroup addOnGroup;
  final Function(List<ItemAddOn>) onAddOnsSelected;
  List<ItemAddOn> selectedAddOns;

  _MultiItemAddOnSelectorState(this.addOnGroup, this.onAddOnsSelected, this.selectedAddOns);

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Container(
      child: SmartSelect<ItemAddOn>.multiple(
        tileBuilder: (ctx, value) {
          return S2Tile(
            trailing: Text("  *", style: themeData.textTheme.bodyText1.apply(color: Colors.red),),
            padding: EdgeInsets.zero,
            title: this.addOnGroup.minItems > 0 ?
              Row(children: [
                Text(addOnGroup.name, style: themeData.textTheme.bodyText2),
                Text("  *", style: themeData.textTheme.bodyText1.apply(color: Colors.red),),
                ],
              ) :
             Text(addOnGroup.name),
            onTap: value.showModal,
            value: value.valueDisplay,
          );
        },
        modalType: S2ModalType.bottomSheet,
        modalHeaderStyle: S2ModalHeaderStyle(textStyle: themeData.textTheme.headline4),
        modalValidation: (state) {
          if (state.length < addOnGroup.minItems) {
            return 'Select at least ${addOnGroup.minItems}';
          } else if (state.length > addOnGroup.maxItems) {
            return 'Select only ${addOnGroup.maxItems}';
          }
          return null;
        },
        modalHeaderBuilder: (ctx, state) {
          return Container(
              padding: const EdgeInsets.all(kDoublePadding),
              height: kToolbarHeight,
              child: Row(
                children: <Widget>[
                  state.modalTitle,
                  const Spacer(),
                  Visibility(
                    visible: !state.changes.valid,
                    child: Text(
                      state.changes?.error ?? '',
                      style: TextStyle(
                        color: kErrorColor
                      ),
                    ),
                  ),
                  Visibility(
                    visible: state.changes.valid,
                    child: FlatButton.icon(
                      padding: EdgeInsets.zero,
                      onPressed: () { state.closeModal(confirmed: true); },
                      icon: Icon(Icons.check),
                      textColor: themeData.primaryColor,
                      label: Text('Add (${state.changes.length})'),
                    )
                  )
                ],
              ),
            );
        },
        modalConfirm: true,
        value: selectedAddOns,
        title: addOnGroup.name,
        placeholder: 'Select one',
        modalFilter: true,
        onChange: (state) {
          this.setState(() {
            selectedAddOns = state.value;
          });
          this.onAddOnsSelected(state.value);
        },
        choiceItems: addOnGroup.addOns.map((e) => S2Choice(
          value: e,
          title: e.name,
          subtitle: formatPrice(e.price)
        )).toList()
      ),
    );
  }
}