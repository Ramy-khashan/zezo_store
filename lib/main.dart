import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/notification/notification_services.dart';
import 'core/utils/functions/app_route.dart';
import 'core/utils/functions/locator_service.dart';
import 'firebase_options.dart';
import 'shop_app.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.wait(
    [
      locator(),
      Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      NotificationService().initNotification(),
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
    ],
  );
  ShopApp.navigatorKey = GlobalKey<NavigatorState>();

  runApp(
    ShopApp(
      appRoute: AppRoute(),
    ),
  );
  FlutterNativeSplash.remove();
}
