import 'package:flutter/material.dart';
import 'package:food_app/constants.dart';

class CheckoutUserInfo extends StatefulWidget {
  CheckoutUserInfo({Key key}) : super(key: key);

  @override
  _CheckoutUserInfoState createState() => _CheckoutUserInfoState();
}

class _CheckoutUserInfoState extends State<CheckoutUserInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kDoublePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(labelText: 'Email', icon: Icon(Icons.email)),
          ),
          SizedBox(height: kPadding),
          TextField(
            decoration: InputDecoration(labelText: 'First Name'),
          ),
          SizedBox(height: kPadding),
          TextField(
            decoration: InputDecoration(labelText: 'Last Name'),
          ),
          SizedBox(height: kPadding),
          TextField(
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(labelText: 'Phone', icon: Icon(Icons.phone)),
          ),
          SizedBox(
            height: kDoublePadding * 2,
          ),
          Text('Delivery Address',
              style: Theme.of(context).textTheme.headline4),
          TextField(
            keyboardType: TextInputType.streetAddress,
            decoration: InputDecoration(labelText: 'Address Line 1'),
          ),
          SizedBox(height: kPadding),
          TextField(
            keyboardType: TextInputType.streetAddress,
            decoration: InputDecoration(labelText: 'Address Line 2'),
          ),
          SizedBox(height: kPadding),
          Row(
            children: [
              Flexible(
                child: TextField(
                  decoration: InputDecoration(labelText: 'City'),
                ),
              ),
              SizedBox(width: kPadding,),
              Flexible(
                child: TextField(
                  decoration: InputDecoration(labelText: 'State'),
                ),
              )
            ],
          ),
          Row(
            children: [
              Flexible(
                child: TextField(
                  maxLength: 5,
                  keyboardType: TextInputType.numberWithOptions(decimal: false),
                  decoration: InputDecoration(labelText: 'Zip Code', counterText: ''),
                ),
              ),
              SizedBox(width: kPadding,),
              Flexible(
                child: SizedBox(width: kPadding),
              )
            ],
          )
        ],
      ),
    );
  }
}
