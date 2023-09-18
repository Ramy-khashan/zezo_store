import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/api/dio_consumer.dart';
import '../../../core/api/end_points.dart';
import '../../../core/constants/storage_keys.dart';
import '../../../core/utils/functions/app_toast.dart';
import '../../../core/utils/functions/camil_case.dart';
import '../../../core/utils/functions/locator_service.dart';
import '../../splash_screen/view/splash_screen.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());
  static ResetPasswordCubit get(context) => BlocProvider.of(context);
  final newPassword = TextEditingController();
  final keyForm = GlobalKey<FormState>();
  bool isLoading = false;
  reserPassword(context) async {
    if (keyForm.currentState!.validate()) {
      String? idToken =
          await const FlutterSecureStorage().read(key: StorageKeys.idToken);
      isLoading = true;
      emit(LoadingResetPasswordState());
      try {
        final res = await serviceLocator
            .get<DioConsumer>()
            .post(EndPoints.resetPassword, body: {
          "idToken": idToken,
          "password": newPassword.text,
          "returnSecureToken": true
        });
        if (Map.from(res).containsKey("error")) {
          if (res["error"]["message"] == "INVALID_ID_TOKEN") {
            appToast(camilCaseMethod(
                "your credential is no longer valid. you must sign in again."));
               await Future.delayed(const Duration(milliseconds: 1500));
           await const FlutterSecureStorage().deleteAll().then((value) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SplashScreen(),
                ),
              );
            });
          } else if (res["error"]["message"] == "WEAK_PASSWORD") {
            appToast(camilCaseMethod(
                "The password must be 6 characters long or more."));
          }
        }
        isLoading = false;

        emit(DoneResetPasswordState());
      } catch (e) {
        appToast(camilCaseMethod("Faied to reset password"));
        isLoading = false;

        emit(FailedResetPasswordState());
      }
    }
  }
}
// 