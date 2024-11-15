import 'package:flutter/material.dart';

class IconButtonItem extends StatelessWidget {
  final IconData icon;
   final void Function() onPressed;
  const IconButtonItem(
      {super.key,
      required this.icon,
       required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Icon(
        icon,
       ),
    );
  }
}
