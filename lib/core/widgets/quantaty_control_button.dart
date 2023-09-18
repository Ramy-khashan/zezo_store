
import 'package:flutter/material.dart';


class QunatityControlButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final void Function() onPressed;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry padding;
  const QunatityControlButton({super.key, required this.color, required this.icon, required this.onPressed, required this.borderRadius, required this.padding});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Material(
        color:color,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
        child: Padding(
          padding: padding,
          child: Icon(
           icon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
