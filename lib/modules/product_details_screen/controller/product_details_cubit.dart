import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../core/api/dio_consumer.dart';
import '../../../core/constants/storage_keys.dart';
import '../../../core/utils/functions/app_toast.dart';
import '../../../core/utils/functions/locator_service.dart';
import '../../category_products/model/product_model.dart';

import '../../../config/app_controller/appcontrorller_cubit.dart';
import '../../../core/api/end_points.dart';
import '../../../shop_app.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());
  static ProductDetailsCubit get(context) => BlocProvider.of(context);
  int quantaty = 1;
  void qunatityPlus() {
    emit(ProductDetailsInitial());
    quantaty++;
    emit(AddingCartState());
  }

  void qunatityMuins() {
    emit(ProductDetailsInitial());

    if (quantaty <= 1) {
    } else {
      quantaty--;
    }
    emit(RemoveCartState());
  }

  bool isFade = false;
  bool isAccepted = false;
  ProductModel? product;
  bool isLoadingProduct = false;
  getProduct(String id) async {
    isLoadingProduct = true;
    emit(LoadingGetProductState());
    final res = await serviceLocator
        .get<DioConsumer>()
        .get("${EndPoints.firestoreBaseUrl}/product/$id");
    product = ProductModel.fromJson(res);
    isLoadingProduct = false;
    emit(SuccessGetProductState());
  }

  String? userId;
  getUSerDetails() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    userId = await storage.read(key: StorageKeys.userId);
  }

  bool isLoadingAddCart = false;

  addToCart() async {
    isLoadingAddCart = true;
    emit(LoadingAddCartState());
    try {
      await AppcontrorllerCubit.get(ShopApp.navigatorKey.currentContext!)
          .addCart(
              productId: product!.fields!.productId!.stringValue!,
              productImg: product!.fields!.mainImage!.stringValue!,
              productPrice: product!.fields!.isOnSale!.booleanValue!
                  ? product!.fields!.onSalePrice!.stringValue!
                  : product!.fields!.price!.stringValue!,
              productTitle: product!.fields!.title!.stringValue!,
              quantaty:quantaty ,
              userId: userId);

      isLoadingAddCart = false;
      await Future.delayed(const Duration(milliseconds: 2000), () {
        isFade = true;
      });

      isFade = false;
      isAccepted = false;
      emit(SuccessAddCartState());
    } catch (error) {
      appToast(error.toString());
      isLoadingAddCart = false;
      emit(FailedAddcartState());
    }
  }
}
