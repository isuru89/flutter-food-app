

import 'package:delizious/model/menu/menu_item.dart';

isMultiChoiceAddOnGroup(ItemAddOnGroup addOnGroup) {
  return addOnGroup.maxPermitted > 1;
}

isSingleChoiceAddOnGroup(ItemAddOnGroup addOnGroup) {
  return addOnGroup.minPermitted < 2 && addOnGroup.maxPermitted < 2;
}

hasAddOnGroups(MenuItem item) {
  return false;
}