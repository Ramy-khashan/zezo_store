import 'package:dartz/dartz.dart';

abstract class OrderDataRepo {
  Future<Either<bool, String>> getAuthToken({required String apiToken});
  // Future<Either<bool, String>> getOrderId(
  //     {required String authToken,
  //     required String price,
  //     required List<Map> items});
  Future<Either<bool, String>> getToken(
      {required String authToken,
      required String orderId,
      required String price,
      required Map map});
}
