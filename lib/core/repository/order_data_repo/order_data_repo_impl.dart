import 'package:dartz/dartz.dart';

import '../../api/dio_consumer.dart';
import '../../api/end_points.dart';
import 'order_data_repo.dart';

class OrderDataRepoImpl extends OrderDataRepo {
  final DioConsumer dio;

  OrderDataRepoImpl({required this.dio});

  @override
  Future<Either<bool, String>> getAuthToken({required String apiToken}) async {
    try {
      final response = await dio
          .post(  EndPoints.authToken, body: {"api_key": apiToken});
     
      return right(response["token"]);
    } catch (e) {
      return left(false);
    }
  }
 

  @override
  Future<Either<bool, String>> getToken(
      {required String authToken,
      required String orderId,
      required String price,
      required Map map}) async {
    try {
      final response = await dio.post( EndPoints.paymentToken, body: {
        "auth_token": authToken,
        "amount_cents": (double.parse(price) * 100).toString(),
        "expiration": price,
        "billing_data": map,
        "currency": "EGP",
        "integration_id": 2081134,
        "lock_order_when_paid": "false"
      });
      return right(response["token"]);
    } catch (e) {
      return left(false);
    }
  }
}
