import 'package:dartz/dartz.dart';

 
abstract class CartProcessRepository {
  Future<Either<String, bool>> checkisExist({required String productId});
  Future<Either<int, int>> cartLength({required String userId});
  Future<Either<String, String>> addToCart(
      {required String userId,
      required int quantaty,
        required String productId,
    required String productImg,
    required String productTitle,
    required String productPrice,});
}
