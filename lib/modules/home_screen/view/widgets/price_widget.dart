import 'package:flutter/material.dart';

import '../../../../core/widgets/text_widget.dart';
 
class PriceWidget extends StatelessWidget {
  final String salePrice, price;
  final bool isOnSale;
  final bool isSmall;
  const PriceWidget({
    super.key,
    required this.salePrice,
    required this.price,
    this.isSmall = false,
    required this.isOnSale,
  });

  @override
  Widget build(BuildContext context) {
    final String userPrice = isOnSale ? salePrice : price;
    return Row(
      children: [
        TextWidget(
          text: '$userPrice ${isOnSale ? "" : "LE"}',
          color: Colors.green.shade300,
          textSize: 20,
        ),
        Visibility(
          visible: isOnSale ? true : false,
          child: Text(
            '$price LE',
            style: TextStyle(
              color: Colors.white,
              decoration: TextDecoration.lineThrough,
              decorationColor: Colors.red.shade300,
              decorationThickness: 3,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}
