import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/api/dio_consumer.dart';
import '../../../core/api/end_points.dart';
import '../../../core/utils/functions/locator_service.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());
  static ForgetPasswordCubit get(context) => BlocProvider.of(context);
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  forgetPassword() async {
    emit(LoadingSendOtpState());
      await serviceLocator
        .get<DioConsumer>()
        .post(EndPoints.forgetPassword, body: {
      "requestType": "PASSWORD_RESET",
      "email": emailController.text.trim() 
    }).then((value) {
      emit(SendOtpState());
      });
  }
}
