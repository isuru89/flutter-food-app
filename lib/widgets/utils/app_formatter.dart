import 'package:intl/intl.dart';

var fmtCalories = new NumberFormat("###", "en_US");
var priceFormatter = new NumberFormat('#0.00');

formatPrice(value) => priceFormatter.format(value);