import 'package:flutter/material.dart';

class CheckoutHeader extends StatelessWidget {

  final String title;

  const CheckoutHeader(this.title, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(title),
    );
  }
}