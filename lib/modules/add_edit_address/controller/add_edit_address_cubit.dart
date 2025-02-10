import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:store/core/utils/functions/app_toast.dart';
import 'package:store/shop_app.dart';

import '../../../core/constants/storage_keys.dart';
import '../model/delivery_address_model.dart';

part 'add_edit_address_state.dart';

class AddEditAddressCubit extends Cubit<AddEditAddressState> {
  AddEditAddressCubit(
      {required bool isAddAddress,
      required DeliveryAddressModel? deliveryAddressModel})
      : super(AddEditAddressInitial()) {
    if (!isAddAddress) {
      editInfo(deliveryAddressModel: deliveryAddressModel!);
    }
  }
  static AddEditAddressCubit get(context) => BlocProvider.of(context);
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  TextEditingController fullName = TextEditingController();
  TextEditingController phone1 = TextEditingController();
  TextEditingController phone2 = TextEditingController();
  TextEditingController fullAddress = TextEditingController();
  TextEditingController landMark = TextEditingController();
  TextEditingController streetName = TextEditingController();
  TextEditingController building = TextEditingController();
  TextEditingController city = TextEditingController();
  addToDeliveryAddress() async {
    isLoading = true;
    emit(LoadingAddEditAddEditAddressState());
    String? userDocID =
        await FlutterSecureStorage().read(key: StorageKeys.userId);
    Random random = Random();
    String id =
        String.fromCharCodes(List.generate(15, (_) => random.nextInt(26) + 65));

    await FirebaseFirestore.instance
        .collection("delivery_address")
        .doc(userDocID)
        .collection("user_delivery_address")
        .doc(id)
        .set({
      "id": id,
      "full_name": fullName.text,
      "phone1": phone1.text,
      "phone2": phone2.text,
      "full_address": fullAddress.text,
      "street": streetName.text,
      "building": building.text,
      "city": city.text,
      "landmark": landMark.text,
      "is_defualt": false
    }).then((value) {
      isLoading = false;
      emit(AddEditAddEditAddressState());

      appToast("Added to delivery address successfully");
      Navigator.pop(ShopApp.navigatorKey.currentContext!);
    }).onError((error, stackTrace) {
      appToast("Failed to add to delivery address");
      isLoading = false;
      emit(FailedAddEditAddEditAddressState());
    });
  }

  editInfo({required DeliveryAddressModel deliveryAddressModel}) {
    fullName.text = deliveryAddressModel.fullName ?? "";
    phone1.text = deliveryAddressModel.phone1 ?? "";

    phone2.text = deliveryAddressModel.phone2 ?? "";
    fullAddress.text = deliveryAddressModel.fullAddress ?? "";
    landMark.text = deliveryAddressModel.landmark ?? "";
    city.text = deliveryAddressModel.city ?? "";
    streetName.text = deliveryAddressModel.street ?? "";
    building.text = deliveryAddressModel.building ?? "";
    // formKey.currentState!.validate();
  }

  editDeliveryAddress(
      {required DeliveryAddressModel deliveryAddressModel}) async {
    isLoading = true;
    emit(LoadingAddEditAddEditAddressState());

    String? userDocID =
        await FlutterSecureStorage().read(key: StorageKeys.userId);

    await FirebaseFirestore.instance
        .collection("delivery_address")
        .doc(userDocID)
        .collection("user_delivery_address")
        .doc(deliveryAddressModel.id)
        .update({
      "full_name":
          fullName.text.isEmpty ? deliveryAddressModel.fullName : fullName.text,
      "phone1": phone1.text.isEmpty ? deliveryAddressModel.phone1 : phone1.text,
      "phone2": phone2.text.isEmpty ? deliveryAddressModel.phone2 : phone2.text,
      "full_address": fullAddress.text.isEmpty
          ? deliveryAddressModel.fullAddress
          : fullAddress.text,
      "landmark":
          landMark.text.isEmpty ? deliveryAddressModel.landmark : landMark.text,
      "building":
          building.text.isEmpty ? deliveryAddressModel.building : building.text,
      "street": streetName.text.isEmpty
          ? deliveryAddressModel.street
          : streetName.text,
      "city": city.text.isEmpty ? deliveryAddressModel.city : city.text,
    }).then((value) {
      isLoading = false;
      emit(AddEditAddEditAddressState());

      appToast("Added to delivery address successfully");
      Navigator.pop(ShopApp.navigatorKey.currentContext!);
    }).onError((error, stackTrace) {
      appToast("Failed to add to delivery address");
      isLoading = false;
      emit(FailedAddEditAddEditAddressState());
    });
  }
}
