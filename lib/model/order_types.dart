enum OrderType {
  Delivery,
  Pickup
}


extension OrderTypeExt on OrderType {

  static const orderTypeKeys = {
    OrderType.Delivery: 'delivery',
    OrderType.Pickup: 'pickup'
  };

  static const orderTypeDisplayNames = {
    OrderType.Delivery: 'Delivery',
    OrderType.Pickup: 'Pickup'
  };

  String get key => orderTypeKeys[this];
  String get displayText => orderTypeDisplayNames[this];

}