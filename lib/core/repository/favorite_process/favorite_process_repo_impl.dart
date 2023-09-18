import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

 import '../../api/dio_consumer.dart';
import '../../api/end_points.dart';
import '../../constants/firestore_keys.dart';
import '../../constants/storage_keys.dart';
import '../../utils/functions/locator_service.dart';
import 'favorite_process_repo.dart';

class FavoriteProcessRepositoryImpl extends FavoriteProcessRepository {
  @override
  Future<Either<String, String>> addToFavorite({
    required String userId,
    required String productId,
    required String productImg,
    required String productTitle,
    required String productPrice,
  }) async {
    try {
      await serviceLocator.get<DioConsumer>().post(
          "${EndPoints.firestoreBaseUrl}/${FirestoreKeys.favorite}/$userId/${FirestoreKeys.favoriteProducts}",
          body: {
            'fields': {
              "product_id": {"stringValue": productId},
              "product_image": {"stringValue": productImg},
              "product_name": {"stringValue": productTitle},
              "price": {"stringValue": productPrice},
            }
          });
      return right("Added Successfully");
    } catch (e) {
      return left("Faild to add product");
    }
  }

  @override
  Future<Either<String, bool>> checkisExist({required String productId}) async {
    String? userId =
        await const FlutterSecureStorage().read(key: StorageKeys.userId);
    try {
      final res = await serviceLocator.get<DioConsumer>().post(
          "${EndPoints.firestoreBaseUrl}/${FirestoreKeys.favorite}/$userId:runQuery",
          body: {
            "structuredQuery": {
              "from": [
                {"collectionId": FirestoreKeys.favoriteProducts}
              ],
              "where": {
                "fieldFilter": {
                  "field": {"fieldPath": "product_id"},
                  "op": "EQUAL",
                  "value": {"stringValue": productId}
                }
              }
            }
          });
      if (!Map.from(res[0]).containsKey("document")) {
        //is not Exist return false
        return right(false);
      } else {
        //is Exist return true
        return right(true);
      }
    } catch (e) {
      return left("Faild to add product");
    }
  }
}
