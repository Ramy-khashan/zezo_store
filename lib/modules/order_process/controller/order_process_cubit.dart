import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../order_payment_data/view/order_data_screen.dart';
part 'order_process_state.dart';

class OrderProcessCubit extends Cubit<OrderProcessState> {
  OrderProcessCubit() : super(OrderProcessInitial());
  static OrderProcessCubit get(context) => BlocProvider.of(context);
  final formKey = GlobalKey<FormState>();
  final addressController = TextEditingController();
  String? radioValue = "cash";
  changeValue(value) {
    emit(OrderProcessInitial());

    radioValue = value;

    emit(ChangValueState());
  }

  bool isLoadingelivery = false;
  getFeeliveryFees() async {
    isLoadingelivery = true;
    emit(GetDeliveryFeesLoadingState());

    await FirebaseFirestore.instance
        .collection("configration")
        .doc("deliveryFees")
        .get()
        .then((value) => delivery = double.parse(value.get("delivery_fees").toString()));
    isLoadingelivery = false;
    emit(GetDeliveryFeesState());
  }

  bool isLoading = false;
  double delivery = 150;

  payment(
    List products,
    totalPrice,
    context,
  ) async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderPaymentDataScreen(
            map: {
              "products": {
                "arrayValue": {"values": products}
              },
              "totalPrice": {"stringValue": totalPrice.toString()},
              "state": const {"stringValue": "waiting"},
              "address": {"stringValue": addressController.text},
              "created_at": {
                "stringValue": DateFormat.yMEd().format(DateTime.now()) +
                    DateFormat.jms().format(DateTime.now())
              },
              "payment": {"stringValue": radioValue},
            },
          ),
        ));
  }
}
