import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../config/app_controller/appcontrorller_cubit.dart';
import '../../../core/constants/storage_keys.dart';
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
 
}
