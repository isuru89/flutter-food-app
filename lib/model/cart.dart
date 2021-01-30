
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:food_app/model/cart_item.dart';

class Cart extends ChangeNotifier {

  final List<CartItem> _items = [];
  double subTotal = 0;
  String orderType = "delivery";
  DateTime orderTime;

  UnmodifiableListView<CartItem> get items => UnmodifiableListView(_items);

  void setOrderReadyTime(DateTime readyTime) {
    orderTime = readyTime;

    notifyListeners();
  }

  void changeOrderType(String newOrderType) {
    orderType = newOrderType;

    notifyListeners();
  }

  void addItem(CartItem newItem) {
    _items.add(newItem);
    _calculateTotal();

    print("Item added");
    notifyListeners();
  }

  void updateItem(CartItem item) {
    _items.removeWhere((it) => it.id == item.id);
    _items.add(item);
    _calculateTotal();

    notifyListeners();
  }

  void removeItem(CartItem item) {
    _items.removeWhere((element) => element.menuItem.id == item.menuItem.id);
    _calculateTotal();

    notifyListeners();
  }

  void increaseQuantity(CartItem item, int by) {
    _items.firstWhere((it) => it == item).quantity++;
    _calculateTotal();

    notifyListeners();
  }

  void decreaseQuantity(CartItem item, int by) {
    _items.firstWhere((it) => it == item).quantity--;
    _calculateTotal();

    notifyListeners();
  }

  void _calculateTotal() {
    subTotal = _items.map((e) => e.menuItem.price * e.quantity)
        .reduce((value, element) => value + element);
  }

  bool canCheckout() {
    return _items.length > 0;
  }
}