import 'package:flutter/material.dart';
import 'package:delizious/model/restaurant.dart';
import 'package:delizious/model/user.dart';

class ActiveUser extends ChangeNotifier {
  User _user;

  List<FavouriteItem> _favourites = [];

  void addToFavourite(FavouriteItem favouriteItem) {
    _favourites.add(favouriteItem);

    notifyListeners();
  }

  void removeFromFavourite(String restaurantId, String itemId) {
    _favourites.removeWhere(
        (f) => f.restaurantId == restaurantId && f.itemId == itemId);

    notifyListeners();
  }

  void makeDefaultCard(String cardId) {
    if (isUserLoggedIn()) {
      PaymentCard prevDefCard =
          _user.paymentCards.firstWhere((c) => c.isDefault == true);
      PaymentCard cardRef =
          _user.paymentCards.firstWhere((c) => c.id == cardId);
      if (cardRef != null && prevDefCard != cardRef) {
        if (prevDefCard != null) {
          prevDefCard.isDefault = false;
        }
        cardRef.isDefault = true;
      }

      notifyListeners();
    }
  }

  void addNewPaymentCard(PaymentCard card) {
    if (isUserLoggedIn()) {
      _user.paymentCards.add(card);

      notifyListeners();
    }
  }

  void removePaymentCard(String cardId) {
    if (isUserLoggedIn()) {
      _user.paymentCards.removeWhere((c) => c.id == cardId);

      notifyListeners();
    }
  }

  void addAddress(Address newAddress) {
    if (isUserLoggedIn()) {
      _user.addresses.add(newAddress);
    }

    notifyListeners();
  }

  void deleteAddress(int addressIndex) {
    if (isUserLoggedIn()) {
      _user.addresses.removeAt(addressIndex);
    }

    notifyListeners();
  }

  void logoutUser() {
    this._user = null;

    notifyListeners();
  }

  void loginUser(User user) {
    this._user = user;

    notifyListeners();
  }

  bool isUserLoggedIn() {
    return _user != null;
  }
}
