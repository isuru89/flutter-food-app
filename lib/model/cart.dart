
import 'package:food_app/model/cart_item.dart';

class Cart {

  List<CartItem> items = [];
  double subTotal = 0;

  void addItem(CartItem newItem) {
    items.add(newItem);
    _calculateTotal();
  }

  void removeItem(CartItem item) {
    items.removeWhere((element) => element.menuItem.id == item.menuItem.id);
    _calculateTotal();
  }

  void increaseQuantity(CartItem item, int by) {

  }

  void decreaseQuantity(CartItem item, int by) {

  }

  void _calculateTotal() {
    subTotal = items.map((e) => e.menuItem.price * e.quantity)
        .reduce((value, element) => value + element);
  }
}