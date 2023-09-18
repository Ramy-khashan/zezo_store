import 'package:flutter/material.dart';

class TextButtonItem extends StatelessWidget {
  final Color backgroundColor, textColor;
  final double textSize;
  final String text;
  final EdgeInsetsGeometry padding;
  final void Function() onPressed;
  const TextButtonItem(
      {super.key,
      required this.backgroundColor,
      required this.textColor,
      required this.textSize,
      required this.onPressed, required this.text, required this.padding});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: padding,
          child: Text(
            text ,
            style: TextStyle(
              color: textColor,
              fontSize: textSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
