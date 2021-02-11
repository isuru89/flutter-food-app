import 'package:flutter/material.dart';

class PriceRangeLabel extends StatelessWidget {

  final String currency;
  final double priceStart;
  final double priceEnd;
  final TextStyle currencyStyle;
  final TextStyle valueStyle;
  final TextStyle decimalStyle;
  final TextStyle endValueStyle;
  final TextStyle endDecimalStyle;
  final bool showCurrencyInStart;
  final bool showCurrencyInEnd;
  final TextStyle separatorTextStyle;

  const PriceRangeLabel(this.priceStart, this.priceEnd, {
    this.currency = '\$',
    this.currencyStyle,
    this.valueStyle,
    this.decimalStyle,
    this.endValueStyle,
    this.endDecimalStyle,
    this.showCurrencyInStart = true,
    this.showCurrencyInEnd = false,
    this.separatorTextStyle
  }) : super();

  factory PriceRangeLabel.create(double priceStart, double priceEnd, {
    currency = '\$',
    currencyStyle,
    valueStyle,
    decimalStyle,
    endValueStyle,
    endDecimalStyle
  }) {
    return PriceRangeLabel(
      priceStart,
      priceEnd,
      currency: currency,
      valueStyle: valueStyle,
      decimalStyle: decimalStyle,
      endValueStyle: endValueStyle ?? valueStyle,
      endDecimalStyle: endDecimalStyle ?? decimalStyle,
      separatorTextStyle: valueStyle,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      textBaseline: TextBaseline.alphabetic,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      children: [
        PriceLabel(priceStart,
          currency: currency,
          currencyStyle: currencyStyle,
          valueStyle: valueStyle,
          decimalStyle: decimalStyle,
          isShowCurrency: showCurrencyInStart,
        ),
        Text("-", style: valueStyle),
        PriceLabel(priceEnd,
          currency: currency,
          currencyStyle: currencyStyle,
          valueStyle: endValueStyle,
          decimalStyle: endDecimalStyle,
          isShowCurrency: showCurrencyInEnd,
        )
      ],
    );
  }

}

class PriceLabel extends StatelessWidget {

  final String currency;
  final double price;
  final TextStyle currencyStyle;
  final TextStyle valueStyle;
  final TextStyle decimalStyle;
  final bool isShowCurrency;
  final double centFontSize;
  final double priceFontSize;

  const PriceLabel(this.price, {
    this.currency: '\$',
    this.valueStyle,
    this.decimalStyle,
    this.currencyStyle,
    this.isShowCurrency = true,
    this.centFontSize = 18,
    this.priceFontSize = 24,
  }) : super();

  @override
  Widget build(BuildContext context) {
    var parts = price.toStringAsFixed(2).split(".");
    var textThemes = Theme.of(context).textTheme;
    return RichText(
      text: TextSpan(
          style: textThemes.headline3.copyWith(fontSize: this.centFontSize, letterSpacing: -1, fontWeight: FontWeight.w500),
          children: [
            if (isShowCurrency) TextSpan(text: "${this.currency}"),
            TextSpan(text: "${parts[0]}", style: valueStyle ?? textThemes.headline3.copyWith(fontSize: priceFontSize)),
            TextSpan(text: ".${parts[1]}", style: decimalStyle)
          ]
      ),
    );
  }


}