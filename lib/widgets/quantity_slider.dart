import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:delizious/constants.dart';

class QuantitySlider extends StatelessWidget {
  final Function() onIncrease;
  final Function() onDecrease;
  final int quantity;

  QuantitySlider(
    this.quantity,
    this.onIncrease,
    this.onDecrease, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: kPrimaryColor,
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: IconButton(
                onPressed: onDecrease,
                color: Colors.grey,
                icon: Icon(Icons.remove, color: kOnPrimaryColor),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: kOnPrimaryColor,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "$quantity",
                    style: TextStyle(color: kPrimaryColor),
                  ),
                ),
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: onIncrease,
                icon: Icon(Icons.add, color: kOnPrimaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
