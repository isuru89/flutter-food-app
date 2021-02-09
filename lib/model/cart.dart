
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:food_app/model/cart_item.dart';
import 'package:food_app/model/order_types.dart';

class Cart extends ChangeNotifier {

  final List<CartItem> _items = [];
  double subTotal = 0;
  double grandTotal = 0;
  double deliveryFee = 0;
  double discount;
  double totalTax;

  OrderType orderType = OrderType.Delivery;
  DateTime orderTime;

  String orderNote;

  UnmodifiableListView<CartItem> get items => UnmodifiableListView(_items);

  void updateOrderNote(String orderNote) {
    this.orderNote = orderNote;

    notifyListeners();
  }

  bool hasTax() {
    return totalTax != null && totalTax > 0;
  }

  bool hasDiscount() {
    return discount != null && discount > 0;
  }

  void updateTax(double totalTax) {
    this.totalTax = totalTax;

    notifyListeners();
  }

  void updateDiscounts(double discount) {
    this.discount = discount;

    notifyListeners();
  }

  void updateDeliveryFee(double newDeliveryFee) {
    this.deliveryFee = newDeliveryFee;

    notifyListeners();
  }

  void setOrderReadyTime(DateTime readyTime) {
    orderTime = readyTime;

    notifyListeners();
  }

  void changeOrderType(OrderType newOrderType) {
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
    var itemPrices = _items.map((e) => e.menuItem.price * e.quantity);
    subTotal = itemPrices.length > 0 ? itemPrices.reduce((value, element) => value + element)  : 0;
    grandTotal = subTotal - (discount ?? 0) + (deliveryFee ?? 0) + (totalTax ?? 0);
  }

  bool hasItems() {
    return _items.length > 0;
  }

  bool canCheckout() {
    return _items.length > 0;
  }
}