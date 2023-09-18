import 'package:flutter/material.dart';
import '../../modules/login/view/widgets/rain_animation.dart';
import '../utils/functions/camil_case.dart';
import '../utils/size_config.dart';

class NotSignPage extends StatelessWidget {
  const NotSignPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          for (int i = 0; i < 40; i++)
            RainAnimation(height: size.height, width: size.width),
          Center(
            child: Text(
              camilCaseMethod("You are in guest mode"),
              style: TextStyle(
                  fontSize: getFont(30),
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
