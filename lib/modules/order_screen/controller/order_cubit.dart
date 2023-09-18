import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/api/dio_consumer.dart';
import '../../../core/api/end_points.dart';
import '../../../core/constants/firestore_keys.dart';
import '../../../core/constants/storage_keys.dart';
import '../../../core/utils/functions/locator_service.dart';
import '../model/order_model.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());
  static OrderCubit get(context) => BlocProvider.of(context);
  String? userId;
  getUserDetails() async {
    isLoadingOrdere = true;
    emit(LoadidngGetOrdersState());
    FlutterSecureStorage storage = const FlutterSecureStorage();
    userId = await storage.read(key: StorageKeys.userId);
    await getOrders();
  }

  List<OrderModel> orders = [];
  bool isLoadingOrdere = false;
  getOrders() async {
    isLoadingOrdere = true;
    orders = [];
    emit(LoadidngGetOrdersState());
    final res = await serviceLocator
        .get<DioConsumer>()
        .post("${EndPoints.firestoreBaseUrl}:runQuery", body: {
      "structuredQuery": {
        "from": [
          {"collectionId": FirestoreKeys.order}
        ],
        "where": {
          "fieldFilter": {
            "field": {"fieldPath": "user_id"},
            "op": "EQUAL",
            "value": {"stringValue": userId}
          }
        }
      }
    });

    if (List.from(res).isNotEmpty) 
    {
      if(Map.from(List.from(res).first).containsKey("document")&&List.from(res).length==1)
      {
        for (var element in res) {
          orders.add(OrderModel.fromJson(element["document"]));
        }
      }
    }
    isLoadingOrdere = false;
    emit(SuccessGetOrdersState());
  }
}
