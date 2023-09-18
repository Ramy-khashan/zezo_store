import 'package:flutter/material.dart';

import '../../../../core/widgets/text_widget.dart';
import '../../../../core/utils/size_config.dart';

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
          text: '$userPrice ',
          color: Colors.green.shade300,
          textSize: getFont(isSmall ? 16 : 22),
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
              fontSize: getFont(isSmall ? 15 : 20),
            ),
          ),
        ),
      ],
    );
  }
}
