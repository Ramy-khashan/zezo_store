import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/route_key.dart';
import '../../../core/utils/functions/app_toast.dart';
import '../../../core/utils/functions/validate.dart';
import '../../../core/utils/size_config.dart';
import '../../../core/widgets/auth_button.dart';
import '../../../core/widgets/back_icon.dart';
import '../../../core/widgets/loading_item.dart';
import '../../../core/widgets/text_widget.dart';
import '../../../core/widgets/textfield_item.dart';
import '../controller/forget_password_cubit.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocProvider(
        create: (context) => ForgetPasswordCubit(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: const BackIcon(),
          ),
          body: Stack(
            children: [
              Center(
                child: Image.asset(
                  "assets/images/zezo_white.png",
                  color: Theme.of(context).brightness.index == 0
                      ? Colors.white.withOpacity(.2)
                      : AppColors.blackColor.withOpacity(.1),
                  height: 600,
                  width: 500,
                  fit: BoxFit.cover,
                 ),
              ),
              BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
                listener: (context, state) {
                  if (state is SendOtpState) {
                    appToast("Check your e-mail to reset your password");
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RouteKeys.loginScreen,
                      (route) => false,
                    );
                  }
                },
                builder: (context, state) {
                  final controller = ForgetPasswordCubit.get(context);
                  return Form(
                    key: controller.formKey,
                    child: Center(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(getWidth(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextWidget(
                              text: 'Forget Password',
                              // color: Colors.white,/
                              textSize: getFont(35),
                              isBold: true,
                            ),
                            SizedBox(
                              height: getHeight(40),
                            ),
                            TextFieldItem(
                              prefexIcon: Icons.email_outlined,
                              hintText: 'Email',
                              controller: controller.emailController,
                              validator: (value) => Validate.validateEmail(value!),
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: getHeight(30),
                            ),
                            state is LoadingSendOtpState
                                ? const LoadingItem()
                                : AppButton(
                                    onPressed: () async {
                                      if (controller.formKey.currentState!
                                          .validate()) {
                                        controller.forgetPassword();
                                      }
                                    },
                                    buttonText: 'Reset Now',
                                    color: Colors.grey),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
