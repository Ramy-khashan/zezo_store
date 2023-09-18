import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/functions/validate.dart';
import '../../../core/widgets/auth_button.dart';
import '../../../core/widgets/loading_item.dart';
import '../../../core/widgets/textfield_item.dart';
import '../controller/reset_password_cubit.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/size_config.dart';
import '../../../core/widgets/back_icon.dart';
import '../../../core/widgets/text_widget.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => ResetPasswordCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: const BackIcon(),
          centerTitle: true,
          title: TextWidget(
            color: AppColors.whiteColor,
            text: 'Reset Password',
            textSize: getFont(26),
            isBold: true,
          ),
        ),
        body: BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
          builder: (context, state) {
            final controller = ResetPasswordCubit.get(context);
            return Form(
              key: controller.keyForm,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(getWidth(14)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextWidget(
                            text:
                                "To Change Your Password, Please Enter Your New Password Down here",
                            color: AppColors.whiteColor,
                            textSize: getFont(24),
                            isBold: true,
                          ),
                          SizedBox(
                            height: getHeight(25),
                          ),
                          TextFieldItem(
                            controller: controller.newPassword,
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.emailAddress,
                            hintText: "New Password",
                            validator: (val) => Validate.validatePassword(val!),
                            obscureText: true,
                            prefexIcon: Icons.password,
                            suffixIcon: Icons.visibility,
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(getWidth(14)),
                    child: controller.isLoading
                        ? const LoadingItem()
                        : AuthButton(
                            onPressed: () {
                              controller.reserPassword(context);
                            },
                            color: Colors.grey.shade400.withOpacity(.6),
                            buttonText: "Reset",
                          ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
