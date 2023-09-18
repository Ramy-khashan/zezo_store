import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../core/widgets/need_login_model_sheet.dart';
import '../../core/constants/storage_keys.dart';
import '../../core/repository/cart_process/cart_process_repo_impl.dart';
import '../../core/utils/functions/app_toast.dart';
import '../../modules/category_products/model/product_model.dart';
import '../../shop_app.dart';
part 'appcontrorller_state.dart';

class AppcontrorllerCubit extends Cubit<AppcontrorllerState> {
  AppcontrorllerCubit() : super(AppcontrorllerInitial());
  static AppcontrorllerCubit get(context) => BlocProvider.of(context);
  List<ProductModel> product = [];
  bool isLoading = true;

  addCart({
    String? userId,
    required int quantaty,
    required String productId,
    required String productImg,
    required String productTitle,
    required String productPrice,
  }) async {
    if (userId != null) {
      final res =
          await CartProcessRepositoryImpl().checkisExist(productId: productId);
      res.fold((l) {
        appToast(l);
      }, (r) async {
        if (r) {
          appToast("Product already exist");
        } else {
          final response = await CartProcessRepositoryImpl().addToCart(
            userId: userId,
            quantaty: quantaty,
            productId: productId,
            productImg: productImg,
            productPrice: productPrice,
            productTitle: productTitle,
          );
          response.fold((l) {
            appToast(l);
          }, (r) {
            appToast(r);
            getCartLenth();
          });
        }
      });
      emit(AddCartState());
    } else {
      needLogin(context: ShopApp.navigatorKey.currentContext!);
    }
  }

  int cartLength = 0;
  getCartLenth() async {
    String? userIdValue =
        await const FlutterSecureStorage().read(key: StorageKeys.userId);
    if (userIdValue != null) {
      emit(AppcontrorllerInitial());
      final res =
          await CartProcessRepositoryImpl().cartLength(userId: userIdValue);
      res.fold((l) => cartLength = l, (r) => cartLength = r);
      emit(GetCartLengthState());
    }
  }
}
