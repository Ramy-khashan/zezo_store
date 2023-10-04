import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../config/app_controller/appcontrorller_cubit.dart';
import '../../../core/api/dio_consumer.dart';
import '../../../core/api/end_points.dart';
import '../../../core/constants/firestore_keys.dart';
import '../../../core/constants/storage_keys.dart';
import '../../../core/utils/functions/locator_service.dart';
import '../../../shop_app.dart';
import '../../category_products/model/product_model.dart';

part 'all_products_state.dart';

class AllProductsCubit extends Cubit<AllProductsState> {
  AllProductsCubit() : super(AllProductsInitial()) {
    // scrollController.addListener(loadMore);
  }
  int limit = 700;
  String nextPageToken = "";
  bool isLoadingMore = false;

  loadMore() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      isLoadingMore = true;
      emit(LoadidngLoadMoreState());
      try {
        final res = await serviceLocator.get<DioConsumer>().get(
            "${EndPoints.firestoreBaseUrl}/${FirestoreKeys.proucts}?pageSize=$limit&pageToken=$nextPageToken");
        for (var element in List.from(res["documents"])) {
          allProduct.add(ProductModel.fromJson(element));
        }
        nextPageToken = res["nextPageToken"];
        product = allProduct;
        serarchCount = product.length;
      } catch (e) {}
      isLoadingMore = false;
      emit(SuccessLoadMoreState());
    }
  }

  static AllProductsCubit get(context) => BlocProvider.of(context);
  ScrollController scrollController = ScrollController();

  int serarchCount = 0;
  bool isLoadingProducts = false;
  bool isFaild = false;
  List<ProductModel> product = [];
  List<ProductModel> allProduct = [];
  getProduct() async {
    isLoadingProducts = true;
    allProduct = [];
    emit(LoadidngGetAllProductState());
 
    try {
      final res = await serviceLocator.get<DioConsumer>().get(
          "${EndPoints.firestoreBaseUrl}/${FirestoreKeys.proucts}?pageSize=$limit");
      for (var element in List.from(res["documents"])) {
        allProduct.add(ProductModel.fromJson(element));
      }
      nextPageToken = res["nextPageToken"] ?? "";
      product = allProduct;
      serarchCount = product.length;

      isLoadingProducts = false;
      emit(SuccessGetAllProductState());
    } catch (e) {
      isLoadingProducts = false;
      isFaild = true;

      product = [];
      emit(FailedGetAllProductState(error: e.toString()));
    }
  }

  void onPressedSearch(val) {
    emit(AllProductsInitial());

    product = allProduct
        .where((element) => element.fields!.title!.stringValue!
            .toLowerCase()
            .contains(val.toString().toLowerCase()))
        .toList();
    serarchCount = product.length;
    emit(OnPressState());
  }

  String? userId;
  getUSerDetails() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    userId = await storage.read(key: StorageKeys.userId);
    await getProduct();
  }

  addToCart(ProductModel product) async {
    await AppcontrorllerCubit.get(ShopApp.navigatorKey.currentContext!).addCart(
        productId: product.fields!.productId!.stringValue!,
        productImg: product.fields!.mainImage!.stringValue!,
        productPrice: product.fields!.isOnSale!.booleanValue!
            ? product.fields!.onSalePrice!.stringValue!
            : product.fields!.price!.stringValue!,
        productTitle: product.fields!.title!.stringValue!,
        quantaty: 1,
        userId: userId!);
  }
}
