import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/loading_item.dart';
import '../../../core/utils/functions/validate.dart';
import '../../../core/widgets/auth_button.dart';
import '../../../core/widgets/text_widget.dart';
import '../../../core/widgets/textfield_item.dart';
import '../../../core/utils/size_config.dart';
import '../controller/register_cubit.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        final controller = RegisterCubit.get(context);
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
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
                Form(
                  key: controller.formKey,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(getWidth(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          height: getHeight(80),
                        ),
                        TextWidget(
                          text: 'Welcome',
                          textSize: getFont(35),
                          isBold: true,
                        ),
                        SizedBox(
                          height: getHeight(10),
                        ),
                        TextWidget(
                          text: 'Sign up to create your account',
                          textSize: getFont(25),
                          isBold: false,
                        ),
                        SizedBox(
                          height: getHeight(40),
                        ),
                        Column(
                          children: [
                            TextFieldItem(
                              prefexIcon: IconlyBold.profile,
                              hintText: 'Full Name',
                              controller: controller.nameController,
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(controller.emailFocusNode),
                              validator: (value) => Validate.validateName(value!),
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.name,
                            ),
                            SizedBox(
                              height: getHeight(20),
                            ),
                            TextFieldItem(
                              prefexIcon: Icons.email_outlined,
                              hintText: 'Email',
                              controller: controller.emailController,
                              focusNode: controller.emailFocusNode,
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(controller.phoneFocusNode),
                              validator: (val) => Validate.validateEmail(val!),
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: getHeight(20),
                            ),
                            TextFieldItem(
                              prefexIcon: Icons.phone_outlined,
                              hintText: 'Phone',
                              controller: controller.phoneController,
                              focusNode: controller.phoneFocusNode,
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(controller.passwordFocusNode),
                              validator: (value) =>
                                  Validate.validateEgyptPhoneNumber(value!),
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: getHeight(20),
                            ),
                            TextFieldItem(
                              prefexIcon: Icons.password,
                              hintText: 'Password',
                              controller: controller.passwordController,
                              focusNode: controller.passwordFocusNode,
                              onEditingComplete: () =>
                                  controller.onSubmitRegister(context),
                              suffixIcon: controller.obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              obscureText: controller.obscureText,
                              onTap: controller.onTapSuffix,
                              validator: (value) =>
                                  Validate.validatePassword(value!),
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.visiblePassword,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: getHeight(50),
                        ),
                        controller.isLoadingRegister
                            ? const LoadingItem()
                            : AppButton(
                                onPressed: () {
                                  controller.onSubmitRegister(context);
                                },
                                buttonText: 'Sign up',
                                color: Colors.grey),
                        SizedBox(
                          height: getHeight(30),
                        ),
                        Center(
                          child: Text.rich(
                         TextSpan(
                                  children: [
                                    const TextSpan(
                                  text: 'Don\'t have an account?',
                                  style: TextStyle(
                                    fontSize: 20,
                                    //fontWeight: FontWeight.bold,
                                  ),),
                                TextSpan(
                                    text: '  Sign in',
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      fontSize:  20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pop(
                                          context,
                                        );
                                      })
                              ])),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
