import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:store/core/constants/storage_keys.dart';

import '../../add_edit_address/model/delivery_address_model.dart';

part 'delivery_address_state.dart';

class DeliveryAddressCubit extends Cubit<DeliveryAddressState> {
  DeliveryAddressCubit() : super(DeliveryAddressInitial());
  static DeliveryAddressCubit get(context) => BlocProvider.of(context);
  List<DeliveryAddressModel> deliveryAddress = [];
  bool isLoading = false;
  getDeliveryAddress() async {
    isLoading = true;
    emit(LoadingGetDeliveryAddressState());
    String? userDocID =
        await FlutterSecureStorage().read(key: StorageKeys.userId);

    await FirebaseFirestore.instance
        .collection("delivery_address")
        .doc(userDocID)
        .collection("user_delivery_address")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        deliveryAddress.add(DeliveryAddressModel.fromJson(element.data()));
      });
      isLoading = false;

      emit(GetDeliveryAddressState());
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      isLoading = false;
      emit(FailedGetDeliveryAddressState());
    });
  }
}
