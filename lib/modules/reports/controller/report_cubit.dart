import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/constants/storage_keys.dart';

part 'report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  ReportCubit() : super(ReportInitial());
  static ReportCubit get(context) => BlocProvider.of(context);
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController reportController = TextEditingController();
  bool isLoadingData = false;
  String? userId = '';
  String? userName = '';
  getIntialVal() async {
    isLoadingData = true;
    emit(LoadingGetDataState());
    const storage = FlutterSecureStorage();
    userId = (await storage.read(key: StorageKeys.userId));
    userName = (await storage.read(key: StorageKeys.userName));
    emailController.text = (await storage.read(key: StorageKeys.userEmail))!;
    phoneController.text = (await storage.read(key: StorageKeys.userPhone))!;
    isLoadingData = false;
    emit(GetDataState());
  }

  bool isLoading = false;
  uploadReport() async {
    isLoading = true;
    emit(StartUploadReporState());
    await FirebaseFirestore.instance.collection("reports").add({
      "report": reportController.value.text.trim(),
      "email": emailController.value.text.trim(),
      "user_name": userName,
      "user_id": userId,
      "phone": phoneController.value.text.trim(),
    }).then((value) async {
      await FirebaseFirestore.instance
          .collection("reports")
          .doc(value.id)
          .update({"report_id": value.id}).onError<FirebaseException>(
              (error, stackTrace) {
        isLoading = false;
        emit(FaildUploadReporState(error: error.message!));
      });
    }).whenComplete(() {
      isLoading = false;
      emailController.clear();
      reportController.clear();
      phoneController.clear();
      emit(SuccessUploadReporState());
    }).onError<FirebaseException>((error, stackTrace) {
      isLoading = false;
      emit(FaildUploadReporState(error: error.message!));
    });
  }
}
