import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constants.dart';

class QuantitySlider extends StatelessWidget {

  final Function() onIncrease;
  final Function() onDecrease;
  final int quantity;

  QuantitySlider(this.quantity, this.onIncrease, this.onDecrease, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          IconButton(
            onPressed: onDecrease,
            icon: Icon(Icons.arrow_drop_down, color: kPrimaryColor),
          ),
          Text("$quantity"),
          IconButton(
            onPressed: onIncrease,
            icon: Icon(Icons.arrow_drop_up, color: kPrimaryColor),
          ),
        ],
      ),
    );
  }
}