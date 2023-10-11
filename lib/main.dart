import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/notification/notification_services.dart';
import 'core/utils/functions/app_route.dart';
import 'core/utils/functions/locator_service.dart';
import 'shop_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  ShopApp.navigatorKey = GlobalKey<NavigatorState>();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await locator();
  await Firebase.initializeApp();
  runApp(
    ShopApp(
      appRoute: AppRoute(),
    ),
  );
}
