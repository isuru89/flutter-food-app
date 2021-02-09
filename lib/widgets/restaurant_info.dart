
import 'package:flutter/material.dart';
import 'package:food_app/constants.dart';
import 'package:food_app/model/restaurant.dart';
import 'package:url_launcher/url_launcher.dart';

class RestaurantInfo extends StatelessWidget {

  final Restaurant restaurant;

  const RestaurantInfo({Key key, this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var addressLine = (this.restaurant.address?.addressLine1 ?? '') + ' ' + (this.restaurant.address?.addressLine2 ?? '');
    var addressSubLine = (this.restaurant.address?.city ?? '') + ' '
      + (this.restaurant.address?.state ?? '')  + ' '
      + (this.restaurant.address?.zipCode ?? '');
    return Container(
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.phone, color: kPrimaryColor,),
            title: Text(this.restaurant.phone),
            onTap: () async {
              await launch('tel:'+ this.restaurant.phone);
            },
          ),
          ListTile(
            leading: Icon(Icons.location_pin, color: kPrimaryColor,),
            title: Text(addressLine),
            subtitle: Text(addressSubLine),
          ),
          if (restaurant.email != null) ListTile(
            leading: Icon(Icons.email, color: kPrimaryColor,),
            title: Text(restaurant.email),
            onTap: () async {
              await launch('mailto:' + restaurant.email);
            },
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: kDoublePadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.food_bank, color: kPrimaryColor,),
                    SizedBox(width: kPadding,),
                    Text("Cuisines:"),
                  ],
                ),
                Wrap(
                  children: this.restaurant.cuisines.map((c) => Chip(label: Text(c),)).toList(),
                  spacing: kPadding,
                  runSpacing: -1 * kPadding,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}