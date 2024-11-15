import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../config/app_controller/appcontrorller_cubit.dart';
import '../../../core/constants/storage_keys.dart';
import '../../../core/notification/notification_services.dart';
import '../../../shop_app.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomePageInitial());
  static HomePageCubit get(context) => BlocProvider.of(context);
 
 
  String? userId;
  getUSerDetails() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    userId = await storage.read(key: StorageKeys.userId);
  }

  addToCart(QueryDocumentSnapshot<Map<String, dynamic>> product) async {
    await AppcontrorllerCubit.get(ShopApp.navigatorKey.currentContext!)
        .addCart(  productId: product.id,
        productImg: product.get("main_image"),
        productPrice: product.get("is_on_sale")
            ?product.get("on_sale_price")
            : product.get("price"),
        productTitle:product.get("title"), quantaty: 1, userId: userId);
  }
  getNotification() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    // await FirebaseMessaging.instance.subscribeToTopic("users");
   await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    try {
      await FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        await NotificationService().initNotification();

        NotificationService().showNotification(
            4, message.notification!.title!, message.notification!.body!);
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
