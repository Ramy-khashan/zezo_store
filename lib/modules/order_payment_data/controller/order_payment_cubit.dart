import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:paymob_payment/paymob_payment.dart';

import '../../../core/api/end_points.dart';
import '../../../core/constants/storage_keys.dart';
import '../../../core/utils/functions/camil_case.dart';
import '../../bottom_navigation_screen/view/bottom_navigation_screen.dart';

part 'order_payment_state.dart';

class OrderPaymentCubit extends Cubit<OrderPaymentState> {
  OrderPaymentCubit() : super(OrderPaymentInitial());
  static OrderPaymentCubit get(context) => BlocProvider.of(context);
  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final streatController = TextEditingController();
  final buildingtController = TextEditingController();
  final cityController = TextEditingController();

  bool isLoadingData = false;
  getIntialVal() async {
    isLoadingData = true;
    emit(OrderPaymentInitial());
    const storage = FlutterSecureStorage();
    fullNameController.text = (await storage.read(key: StorageKeys.userName))!;
    emailController.text = (await storage.read(key: StorageKeys.userEmail))!;
    phoneController.text = (await storage.read(key: StorageKeys.userPhone))!;
    isLoadingData = false;
    emit(GetUserDataState());
  }

  initializePayment() async {
    PaymobPayment.instance.initialize(
      apiKey: EndPoints.apiToken,
      integrationID: EndPoints.integrationID,
      iFrameID: EndPoints.iFrameID,
    );
  }

  bool isLoadingCreateOrder = false;
  createOrder({required Map map, required BuildContext context}) async {
    isLoadingCreateOrder = true;
    emit(LoadingCreateState());
    map.addAll({
      "full_name": fullNameController.text,
      "email": emailController.text,
      "phone_number": "+2${phoneController.text}",
      "building": buildingtController.text.trim(),
      "status": "waiting",
      "street": int.parse(streatController.text),
      "address": addressController.text,
      "city": cityController.text.trim(),
      "user_id":
          await const FlutterSecureStorage().read(key: StorageKeys.userId)
    });

    await FirebaseFirestore.instance
        .collection("order")
        .add({"products": map}).then((value) async {
      FirebaseFirestore.instance
          .collection("order")
          .doc(value.id)
          .update({"order_id": value.id, "payment_status": "success"});
      if (map['payment'] == "cash") {
        Fluttertoast.showToast(msg: "Create Order Successfuly");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const BottomNavigationScreen(),
            ),
            (route) => false);
      } else {
        await PaymobPayment.instance.pay(
          context: context,
          currency: "EGP",
          // items: map['products'],
          amountInCents: (double.parse(map['totalPrice'].toString()) * 10).toString(),
          onPayment: (response) async {
            await FirebaseFirestore.instance
                .collection("order")
                .doc(value.id)
                .update({
              "payment_status": response.success,
              "payment_transaction_id": response.transactionID,
            }).then((value) {
              Fluttertoast.showToast(
                msg: response.success
                    ? "Create Order Successfuly"
                    : camilCaseMethod("Failed to create your order"),
              );
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BottomNavigationScreen(),
                  ),
                  (route) => false);
            });
          },
        );
    
      }
      isLoadingCreateOrder = false;
      emit(SucessCreateState());
    }).onError((error, stackTrace) {
      print(error);
      Fluttertoast.showToast(
        msg: camilCaseMethod("Failed to create your order"),
      );
      isLoadingCreateOrder = false;
      emit(FailedCreateState());
    });
  }
}
