
import 'menu/menu_item.dart';

class CartItem {

  final String id;
  final MenuItem menuItem;
  Map<String, List<String>> addOns;
  int quantity;

  CartItem(this.id, this.menuItem, this.quantity, { this.addOns });

  bool operator ==(item) => item is CartItem && item.id == id;

  @override
  int get hashCode => id.hashCode;


}