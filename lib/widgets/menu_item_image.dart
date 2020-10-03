import 'package:flutter/material.dart';

class MenuItemImage extends StatelessWidget {

  final String imageUrl;
  final bool isSoldOut;
  final double width;
  final double height;

  const MenuItemImage({Key key, this.imageUrl, this.isSoldOut = false, this.width = 80, this.height = 80}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: Stack(
        children: [
          FadeInImage.assetNetwork(
            placeholder: 'assets/images/placeholder.png',
            image: imageUrl,
            fit: BoxFit.cover,
            height: height,
            width: width,
          ),
          if (isSoldOut) Positioned(
            bottom: 0,
            width: width,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).errorColor
                      ),
                      child: Center(child: Text("Sold out", style: TextStyle(color: Colors.white)))
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

}