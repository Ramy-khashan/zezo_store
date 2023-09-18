import 'package:flutter/material.dart';

import '../utils/size_config.dart';

class AuthButton extends StatelessWidget {
  final void Function() onPressed;
  final String? buttonText;
  final Color?textColor;
  final Color color;
  final Widget? child;
  const AuthButton(
      {super.key,
      required this.onPressed,
        this.buttonText,
      required this.color, this.child, this.textColor=  const Color.fromARGB(255, 249, 246, 246)});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(vertical: getHeight(15))
        ),
        child: child??Text(
          buttonText!,
          style: TextStyle(
            color: textColor,
            fontSize: getFont(22),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
