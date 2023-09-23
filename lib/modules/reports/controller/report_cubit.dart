import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  ReportCubit() : super(ReportInitial());
  static ReportCubit get(context) => BlocProvider.of(context);
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController reportController = TextEditingController();
  bool isLoading = false;
  uploadReport() async {
    isLoading = true;
    emit(StartUploadReporState());
    await FirebaseFirestore.instance.collection("reports").add({
      "report": reportController.value.text.trim(),
      "email": emailController.value.text.trim(),
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
