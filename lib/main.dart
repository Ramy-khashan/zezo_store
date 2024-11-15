import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/notification/notification_services.dart';
import 'core/utils/functions/app_route.dart';
import 'core/utils/functions/locator_service.dart';
import 'shop_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait(
    [
      locator(),
      Firebase.initializeApp(
          // options: DefaultFirebaseOptions.currentPlatform,
          ),
      NotificationService().initNotification(),
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
    ],
  );

  // print(await FirebaseMessaging.instance.getToken());

  ShopApp.navigatorKey = GlobalKey<NavigatorState>();

  runApp(
    ShopApp(
      appRoute: AppRoute(),
    ),
  );
}
