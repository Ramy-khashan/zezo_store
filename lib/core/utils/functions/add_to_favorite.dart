 import '../../../shop_app.dart';
import '../../repository/favorite_process/favorite_process_repo_impl.dart';
import '../../widgets/need_login_model_sheet.dart';
import 'app_toast.dart';

addTofavorite({
  String? userId,
  required String productId,
  required String productImg,
  required String productTitle,
  required String productPrice,
}) async {
  if (userId != null) {
    final res = await FavoriteProcessRepositoryImpl()
        .checkisExist(productId: productId);
    res.fold((l) {
      appToast(l);
    }, (r) async {
      if (r) {
        appToast("Product already exist");
      } else {
        final response = await FavoriteProcessRepositoryImpl().addToFavorite(
          userId: userId,
          productId: productId,
          productPrice: productPrice,
          productTitle: productTitle,
          productImg: productImg,
        );
        response.fold((l) {
          appToast(l);
        }, (r) {
          appToast(r);
        });
      }
    });
  } else {
    needLogin(context: ShopApp.navigatorKey.currentContext!);
  }
}
