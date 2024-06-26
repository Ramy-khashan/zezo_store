import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/route_key.dart';
import '../utils/size_config.dart';
import 'auth_button.dart';
import 'text_widget.dart';

class EmptyScreen extends StatelessWidget {
  final String imagePath, headText, text, textButton;
  const EmptyScreen(
      {super.key,
      required this.imagePath,
      required this.headText,
      required this.text,
      required this.textButton});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.fill,
              width: getWidth(220),
              height: getHeight(220),
            ),
            SizedBox(
              height: getHeight(20),
            ),
            TextWidget(
              text: 'Whoops!',
              color: Colors.redAccent,
              textSize: getFont(35),
              isBold: true,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              headText,
              style: const TextStyle(color: Colors.cyan, fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              text,
              style: const TextStyle(color: Colors.cyan, fontSize: 20),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 250,
              child: AppButton(
                color: Theme.of(context).primaryColor,
                onPressed: () =>
                    Navigator.pushNamed(context, RouteKeys.allProductScreen),
                child: TextWidget(
                  text: textButton,
                  color: AppColors.whiteColor,
                  textSize: 20,
                  isBold: true,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
