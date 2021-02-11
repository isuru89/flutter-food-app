import 'package:intl/intl.dart';

var fmtCalories = new NumberFormat("###", "en_US");
var priceFormatter = new NumberFormat('#0.00');
var orderReadyTimeFormatter = DateFormat(" E,").add_jm();

formatPrice(value) => priceFormatter.format(value);

formatOrderReadyTime(DateTime dateTime) {
  var daySuffix = "${dateTime.day}";
  print(dateTime.day % 10);
  if (dateTime.day % 10 == 1 && dateTime.day != 11) {
    daySuffix += "st";
  } else if (dateTime.day % 10 == 2 && dateTime.day != 12) {
    daySuffix += "nd";
  } else if (dateTime.day % 10 == 3 && dateTime.day != 13) {
    daySuffix += "rd";
  } else {
    daySuffix += "th";
  }
  return daySuffix + orderReadyTimeFormatter.format(dateTime);
}
