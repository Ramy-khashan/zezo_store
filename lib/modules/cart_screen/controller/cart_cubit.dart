import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../core/utils/functions/locator_service.dart';
import '../../../shop_app.dart';
import '../../../config/app_controller/appcontrorller_cubit.dart';
import '../../../core/api/dio_consumer.dart';
import '../../../core/api/end_points.dart';
import '../../../core/constants/firestore_keys.dart';
import '../../../core/constants/storage_keys.dart';
import '../model/cart_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  static CartCubit get(context) => BlocProvider.of(context);
  getUserDetails() async {
    isLoadingAddCart = true;
    emit(LoadingGetCartState());
    FlutterSecureStorage storage = const FlutterSecureStorage();
    userId = await storage.read(key: StorageKeys.userId);
    await getCart();
  }

  double totalPrice = 0;
  getTotalPrice() {
    totalPrice = 0;
    for (var element in cartProducts) {
      totalPrice += double.parse(element.fields!.price!.stringValue!) *
          int.parse(element.fields!.quantity!.integerValue!);
    }
  }

  String? userId;
  int quantaty = 1;

  void qunatityPlus(index) {
    emit(CartInitial());
    cartProducts[index].fields!.quantity!.integerValue =
        (int.parse(cartProducts[index].fields!.quantity!.integerValue!) + 1)
            .toString();
    getTotalPrice();
    updateCartItem(index: index);

    emit(AddingCartState());
  }

  void qunatityMuins(index) {
    emit(CartInitial());

    if (int.parse(cartProducts[index].fields!.quantity!.integerValue!) > 1) {
      cartProducts[index].fields!.quantity!.integerValue =
          (int.parse(cartProducts[index].fields!.quantity!.integerValue!) - 1)
              .toString();
    }
    getTotalPrice();
    updateCartItem(index: index);
    emit(RemoveCartState());
  }

  deleteItem({index, id}) async{
    emit(CartInitial());

    cartProducts.removeAt(index);
    getTotalPrice();

    emit(RemoveItemFromCartState());
    try {
     await serviceLocator.get<DioConsumer>().delete(
          "${EndPoints.firestoreBaseUrl}/${FirestoreKeys.cart}/$userId/${FirestoreKeys.cartProducts}/$id");
     await AppcontrorllerCubit.get(ShopApp.navigatorKey.currentContext)
          .getCartLenth( );
    // ignore: empty_catches
    } catch (e) {}
  }

  List<CartModel> cartProducts = [];
  bool isLoadingAddCart = false;
  getCart() async {
    cartProducts = [];
    try {
      final res = await serviceLocator.get<DioConsumer>().get(
          "${EndPoints.firestoreBaseUrl}/${FirestoreKeys.cart}/$userId/${FirestoreKeys.cartProducts}");
      for (var element in List.from(res["documents"])) {
        cartProducts.add(CartModel.fromJson(element));
      }

      getTotalPrice();

      isLoadingAddCart = false;
      emit(SucessGetCartState());
    } catch (error) {
      isLoadingAddCart = false;
      emit(FailedGetCartState());
    }
  }

  updateCartItem({required int index}) {
    serviceLocator.get<DioConsumer>().patch(
        "${EndPoints.firestoreBaseUrl}/${FirestoreKeys.cart}/$userId/${FirestoreKeys.cartProducts}/${cartProducts[index].name!.split("/").last}?updateMask.fieldPaths=quantity",
        body: {
          "fields": {
            "quantity": {
              "integerValue":
                  cartProducts[index].fields!.quantity!.integerValue!
            },
          }
        });
  }
}
