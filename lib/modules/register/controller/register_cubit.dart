import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/route_key.dart';
import '../../../core/repository/register/register_repository_impl.dart';
import '../../../core/utils/functions/app_toast.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterRepositoryImpl registerRepositoryImpl;
  RegisterCubit({required this.registerRepositoryImpl})
      : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  bool obscureText = true;

  void onTapSuffix() {
    emit(RegisterInitial());

    obscureText = !obscureText;
    emit(ShowPasswordState());
  }

  bool isLoadingRegister = false;
  void onSubmitRegister(BuildContext context) async {
    FocusScope.of(context).unfocus();

    if (formKey.currentState!.validate()) {
          isLoadingRegister = true;
    emit(LoadingRegisterState());
      final res = await registerRepositoryImpl.register(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          name: nameController.text.trim(),
          phone: phoneController.text.trim());
      res.fold((l) {
        isLoadingRegister = false;
        emit(FaildRegisterState());
        appToast(l.message.toString());
      }, (r) {
        appToast(r.toString());

        isLoadingRegister = false;
        emit(SuccessRegisterState());
        Navigator.pushNamedAndRemoveUntil(
            context, RouteKeys.loginScreen, (route) => false);
      });
    }
  }
}
