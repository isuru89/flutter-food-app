import 'package:flutter/material.dart';
import 'package:delizious/constants.dart';

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
                  color: Colors.black12,
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