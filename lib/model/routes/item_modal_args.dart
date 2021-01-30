
import 'package:food_app/model/menu/menu_item.dart';

import '../cart_item.dart';

class ItemModalArguments {
  final CartItem cartItem;
  final MenuItem menuItem;
  final String heroTag;

  ItemModalArguments(this.menuItem, { this.heroTag, this.cartItem });

}