import 'package:flutter/material.dart';

class ItemInfoBar extends StatelessWidget {

  final double price;
  final double calories;
  final bool showFoodLabels;
  final List<String> foodLabels;

  const ItemInfoBar({Key key, this.price, this.calories, this.showFoodLabels = true, this.foodLabels = const []}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "\$$price",
          style: const TextStyle(fontWeight: FontWeight.w200, fontSize: 12),
        ),
        SizedBox(width: 6),
        Text("∙", style: const TextStyle(fontWeight: FontWeight.w200, fontSize: 12)),
        SizedBox(width: 6),
        Text("$calories cal", style: const TextStyle(fontWeight: FontWeight.w200, fontSize: 12)),
        SizedBox(width: 6),
        if (showFoodLabels) ...foodLabels.map((e) => Text(e)).toList()
      ],
    );
  }

}