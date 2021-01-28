import 'package:flutter/material.dart';
import 'package:food_app/constants.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class CheckoutPaymentSection extends StatefulWidget {
  CheckoutPaymentSection({Key key}) : super(key: key);

  @override
  _CheckoutPaymentSectionState createState() => _CheckoutPaymentSectionState();
}

class _CheckoutPaymentSectionState extends State<CheckoutPaymentSection> {

  MaskedTextController _controller = MaskedTextController(mask: '0000 0000 0000 0000', text: '0000 0000 0000 0000');

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(kDoublePadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Cart Total', style: themeData.textTheme.headline4),
              Text('\$68.99', style: themeData.textTheme.headline3)
            ],
          )
        ),
        Divider(),
        Container(
          padding: const EdgeInsets.all(kDoublePadding),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                style: themeData.textTheme.headline4,
                decoration: InputDecoration(
                  labelText: 'Credit Cart Number',
                  hintText: '0000 0000 0000 0000',
                  hintStyle: themeData.textTheme.headline4.copyWith(color: Colors.grey.withAlpha(196))
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
              ),
            ],
          ),
        )
      ],
    );
  }
}