import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final Color? color;
  final double? textSize;
  final bool isBold;
  final int? maxlines;
  const TextWidget({
    super.key,
    required this.text,
    required this.color,
    this.isBold = false,
    required this.textSize,
    this.maxlines = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: textSize,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      ),
      maxLines: maxlines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
