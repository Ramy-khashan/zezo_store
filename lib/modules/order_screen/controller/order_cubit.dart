import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/constants/storage_keys.dart';
import '../../../core/utils/enums.dart';
import '../models/order_model.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderState());
  String? userId;
  bool isLoading = false;
  getOrders() async {
    emit(state.copyWith(status: OperationStatus.loading));
    FlutterSecureStorage storage = const FlutterSecureStorage();
    userId = await storage.read(key: StorageKeys.userId);
    print("enter");
    print(userId);
    FirebaseFirestore.instance
        .collection("order")
        .where("user_id", isEqualTo: userId)
        .get()
        .then(
      (value) {
        List<OrderModel> orders = [];
        print("lol");
        value.docs.forEach((element) {
          orders.add(OrderModel.fromJson(element.data()));
        });
        emit(state.copyWith(status: OperationStatus.success, orders: orders));
      },
    ).onError((error, stackTrace) {
      emit(state.copyWith(status: OperationStatus.failed, orders: []));
    });
  }
}
