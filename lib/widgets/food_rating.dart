import 'package:flutter/material.dart';

class FoodRating extends StatelessWidget {
  final double rating;
  final double size;
  final double starSize;

  const FoodRating(this.rating, {this.size = 12, this.starSize = 18, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Icon(
              Icons.star,
              color: Colors.yellow,
              size: this.starSize,
            ),
          ),
          Text(
            "$rating",
            style: TextStyle(fontSize: this.size),
          ),
        ],
      ),
    );
  }
}
