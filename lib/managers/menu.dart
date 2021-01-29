

import 'package:food_app/model/menu/menu_item.dart';

isMultiChoiceAddOnGroup(ItemAddOnGroup addOnGroup) {
  return addOnGroup.maxItems > 1;
}

isSingleChoiceAddOnGroup(ItemAddOnGroup addOnGroup) {
  return addOnGroup.minItems < 2 && addOnGroup.maxItems < 2;
}

hasAddOnGroups(MenuItem item) {
  return item.addOnGroups != null && item.addOnGroups.length > 0;
}