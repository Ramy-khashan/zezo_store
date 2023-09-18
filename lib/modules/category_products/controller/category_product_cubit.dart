import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../config/app_controller/appcontrorller_cubit.dart';
import '../../../core/api/dio_consumer.dart';
import '../../../core/api/end_points.dart';
import '../../../core/constants/firestore_keys.dart';
import '../../../core/constants/storage_keys.dart';
import '../../../core/utils/functions/locator_service.dart';
import '../../../shop_app.dart';
import '../model/product_model.dart';

part 'category_product_state.dart';

class CategoryProductCubit extends Cubit<CategoryProductState> {
  CategoryProductCubit(this.dio) : super(CategoryProductInitial());

  final DioConsumer dio;

  static CategoryProductCubit get(context) => BlocProvider.of(context);

  bool isLoadingProducts = false;
  bool isFaild = false;
  List<ProductModel> product = [];
  List<ProductModel> allProduct = [];
  getproduct({required String id}) async {
    isLoadingProducts = true;
    allProduct = [];
    emit(LoadidngGetProductState());

    try {
      final res = await serviceLocator
          .get<DioConsumer>()
          .post("${EndPoints.firestoreBaseUrl}:runQuery?", body: {
        "structuredQuery": {
          "from": [
            {"collectionId": FirestoreKeys.proucts}
          ],
          "where": {
            "fieldFilter": {
              "field": {"fieldPath": "category"},
              "op": "EQUAL",
              "value": {"stringValue": id}
            }
          },
        }
      });
      for (var element in List.from(res)) {
        allProduct.add(ProductModel.fromJson(element["document"]));
      }
      product = allProduct;
      isLoadingProducts = false;
      emit(SuccessGetProductState());
    } catch (e) {
      isLoadingProducts = false;
      isFaild = true;

      product = [];
      emit(FailedGetProductState(error: e.toString()));
    }
  }

  String? userId;
  getUSerDetails() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    userId = await storage.read(key: StorageKeys.userId);
  }

  addToCart(ProductModel product) async {
    await AppcontrorllerCubit.get(ShopApp.navigatorKey.currentContext!)
        .addCart(  productId: product.fields!.productId!.stringValue!,
        productImg: product.fields!.mainImage!.stringValue!,
        productPrice: product.fields!.isOnSale!.booleanValue!
            ? product.fields!.onSalePrice!.stringValue!
            : product.fields!.price!.stringValue!,
        productTitle: product.fields!.title!.stringValue!, quantaty: 1, userId: userId);
  }
}
