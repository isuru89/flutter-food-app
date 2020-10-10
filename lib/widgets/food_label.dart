import 'package:flutter/material.dart';

class Labels {

  static createCalorieLabel(num calories, TextStyle style) {
    return Text('$calories cal', style: style);
  }

  static createItemNameLabel(String name, TextStyle style, { maxLines = 2 }) {
    return Text(
      name,
      softWrap: true,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: style,
    );
  }

  static createFoodLabels(List<String> foodLabels) {
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: foodLabels.map((e) => FoodLabel(e)).toList(),
    );
  }
}

class FoodLabel extends StatelessWidget {

  final String label;
  final TextStyle textStyle;
  final Color backgroundColor;

  const FoodLabel(this.label, {Key key, this.textStyle, this.backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var txtStyle = textStyle ?? Theme.of(context).textTheme.subtitle1;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: backgroundColor ?? Colors.black12,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Text(label, style: txtStyle),
      ),
    );
  }

}