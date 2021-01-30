
import 'menu/menu_item.dart';

class CartItem {

  final String id;
  final MenuItem menuItem;

  int quantity;

  CartItem(this.id, this.menuItem, this.quantity);

  bool operator ==(item) => item is CartItem && item.id == id;

  @override
  int get hashCode => id.hashCode;


}