import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/constants/firestore_keys.dart';
import '../../../core/constants/storage_keys.dart';
import '../../../core/notification/notification_services.dart';
import '../../../core/utils/functions/app_toast.dart';
import '../../../shop_app.dart';

part 'special_order_state.dart';

class SpecialOrderCubit extends Cubit<SpecialOrderState> {
  SpecialOrderCubit() : super(SpecialOrderInitial());
  static SpecialOrderCubit get(context) => BlocProvider.of(context);
  bool isLoadingData = true;
  getData() async {
    const storage = FlutterSecureStorage();
    emailController.text = (await storage.read(key: StorageKeys.userEmail))!;
    fullNameController.text = (await storage.read(key: StorageKeys.userName))!;
    phoneController.text = (await storage.read(key: StorageKeys.userPhone))!;
    userId = (await storage.read(key: StorageKeys.userId))!;
    isLoadingData = false;
    emit(GetDataState());
  }

  String? userId;
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final orderController = TextEditingController();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final descriptionController = TextEditingController();
  final addressController = TextEditingController();
  bool isClick = false;
  bool isLoading = false;
    createOrder() async {
    if (key.currentState!.validate()) {
      isLoading = true;
      emit(LoadingSpecialOrderState());
      try {
        await FirebaseFirestore.instance
            .collection(FirestoreKeys.specialOrder)
            .add({
          "phone": phoneController.text,
          "address": addressController.text,
          "user_id": userId,
          "status": "in_progress",
          "special_order": orderController.text.trim(),
          "full_name": fullNameController.text.trim(),
          "description": descriptionController.text.trim(),
          "email": emailController.text.trim()
        }).whenComplete(() {
          orderController.clear();
          addressController.clear();
          descriptionController.clear();
          isLoading = false;
            FocusScopeNode focusScopeNode = FocusScope.of(ShopApp.navigatorKey.currentContext!);
        if (!focusScopeNode.hasPrimaryFocus) {
          return focusScopeNode.unfocus();
        }
          emit(SuccessSpecialOrderState());
          // appToast("Order Created Successfully");
          NotificationService().showNotification(
        Random().nextInt(10000), "Zezo Store", "Your special order has been created successfully");
        });
      } catch (e) {
        isLoading = false;
        emit(FailedSpecialOrderState());
         NotificationService().showNotification(
        Random().nextInt(10000), "Zezo Store", "Failed To Create This Order");
        appToast("");
      }
    }
  }
}
