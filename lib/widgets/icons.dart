import 'package:flutter/material.dart';
import 'package:food_app/constants.dart';

class IconUtils {

  static createShadowIcon(Icon icon, double iconSize) {
    return Stack(
      children: [
        Container(
          width: iconSize,
          height: iconSize,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black38,
                  blurRadius: kDoublePadding
              )
            ]
          ),
        ),
        icon
      ],
    );
  }

}