import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../constants/firestore_keys.dart';
import '../../constants/storage_keys.dart';
import 'cart_process_repo.dart';

class CartProcessRepositoryImpl extends CartProcessRepository {
  @override
  Future<Either<String, String>> addToCart({
    required String userId,
    required int quantaty,
    required String productId,
    required String productImg,
    required String productTitle,
    required String productPrice,
  }) async {
    try {
      FirebaseFirestore.instance
          .collection(FirestoreKeys.cart)
          .doc(userId)
          .collection(FirestoreKeys.cartProducts)
          .add({
        "product_id": productId,
        "product_image": productImg,
        "product_name": productTitle,
        "price": productPrice,
        'quantity': quantaty
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
      QuerySnapshot<Map<String, dynamic>> value = await FirebaseFirestore
          .instance
          .collection(FirestoreKeys.cart)
          .doc(userId)
          .collection(FirestoreKeys.cartProducts)
          .where("product_id", isEqualTo: productId)
          .get();

      return value.docs.isEmpty ? right(false) : right(true);
    } catch (e) {
      return left("Faild to add product");
    }
  }

  @override
  Future<Either<int, int>> cartLength({required String userId}) async {
    try {
      QuerySnapshot<Map<String, dynamic>> value = await FirebaseFirestore
          .instance
          .collection(FirestoreKeys.cart)
          .doc(userId)
          .collection(FirestoreKeys.cartProducts)
          .get();

      if (value.docs.isNotEmpty) {
        return right(value.docs.length);
      } else {
        return right(0);
      }
    } catch (e) {
      return left(0);
    }
  }
}
