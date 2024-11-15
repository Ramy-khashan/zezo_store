import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../core/constants/route_key.dart';
import '../../../core/constants/storage_keys.dart';
import '../../../core/utils/size_config.dart';
import '../../../shop_app.dart';
// import '../../login/view/widgets/rain_animation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(milliseconds: 3000), () async {
      String? userId =
          await const FlutterSecureStorage().read(key: StorageKeys.userId);
      Navigator.pushNamedAndRemoveUntil(
          ShopApp.navigatorKey.currentContext!,
          userId != null ? RouteKeys.homeScreen : RouteKeys.loginScreen,
          (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
        body: Center(
            child: Stack(
      children: [
        // for (int i = 0; i < 40; i++)
        //   RainAnimation(height: size.height, width: size.width),
        Center(
          child: Image.asset(
            Theme.of(context).brightness.index == 0
                ? "assets/images/zezo_white.png"
                : "assets/images/zezo.png",
            fit: BoxFit.contain,
          ),
        ),
      ],
    )));
  }
}
