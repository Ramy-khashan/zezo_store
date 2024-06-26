import 'package:dartz/dartz.dart';

abstract class FavoriteProcessRepository {
  Future<Either<String, bool>> checkisExist({required String productId});
  Future<Either<String, String>> addToFavorite({
    required String userId,
    required String productId,
    required String productImg,
    required String productTitle,
    required String productPrice,
  });
}
