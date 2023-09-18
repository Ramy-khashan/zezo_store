import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
 import '../constants/route_key.dart';
import '../utils/size_config.dart';
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
    return   Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
      child: Column(mainAxisSize: MainAxisSize.min,
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
          SizedBox(
            height: getHeight(30),
          ),
          TextWidget(
              text: headText, color: Colors.cyan, textSize: getFont(24)),
          SizedBox(
            height: getHeight(20),
          ),
          TextWidget(text: text, color: Colors.cyan, textSize: getFont(24)),
          SizedBox(
            height: getHeight(30),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(width: 1, color: AppColors.blackColor),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 20,
                )),
            onPressed: () => Navigator.pushNamed(
                context, RouteKeys.allProductScreen),
            child: TextWidget(
              text: textButton,
              color: AppColors.whiteColor,
              textSize: getFont(22),
              isBold: true,
            ),
          )
        ],
      ),
        ),
       
    );
  }
}
