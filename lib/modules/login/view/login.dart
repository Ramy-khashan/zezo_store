import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/route_key.dart';
import '../../../core/utils/functions/app_toast.dart';
import '../../../core/utils/functions/validate.dart';
import '../../../core/utils/size_config.dart';
import '../../../core/widgets/auth_button.dart';
import '../../../core/widgets/loading_item.dart';
import '../../../core/widgets/text_widget.dart';
import '../../../core/widgets/textfield_item.dart';
import '../controller/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            final controller = LoginCubit.get(context);

            return SingleChildScrollView(
              padding: EdgeInsets.all(getWidth(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: getHeight(70),
                  ),
                  TextWidget(
                    text: 'Welcome Back',
                    color: Colors.white,
                    textSize: getFont(35),
                    isBold: true,
                  ),
                  SizedBox(
                    height: getHeight(10),
                  ),
                  TextWidget(
                    text: 'Sign in to continue',
                    color: Colors.white,
                    textSize: getFont(25),
                    isBold: false,
                  ),
                  SizedBox(
                    height: getHeight(30),
                  ),
                  Form(
                    key: controller.formKeyLogin,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFieldItem(
                          prefexIcon: Icons.email_outlined,
                          hintText: 'Email',
                          controller: controller.emailController,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(controller.passwordFocusNode),
                          validator: (value) =>
                              Validate.validateEmail(value!),
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
                              controller.onSubmitLogin(context),
                          suffixIcon: controller.obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          obscureText: controller.obscureText,
                          onTap: controller.onTapSuffix,
                          validator: (value) => Validate.notEmpty(value!),
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.visiblePassword,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: getHeight(30),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(
                          context, RouteKeys.forgetPasswordScreen),
                      child: Text(
                        'Forget Password',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: getFont(22),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getHeight(20),
                  ),
                  controller.isLoadginEmail
                      ? const LoadingItem()
                      : AuthButton(
                          onPressed: () {
                            controller.isLoadingSignInGoogle
                                ? appToast("In Authentication Process")
                                : controller.onSubmitLogin(context);
                          },
                          buttonText: 'Login',
                          color: Colors.grey.shade400.withOpacity(.6)),
                  SizedBox(
                    height: getHeight(20),
                  ),
                  controller.isLoadingSignInGoogle
                      ? const LoadingItem()
                      : AuthButton(
                          onPressed: () {
                            controller.isLoadginEmail
                                ? appToast("In Authentication Process")
                                : controller.signInWithGoogle(context);
                          },
                          color: Colors.grey.shade400.withOpacity(.6),
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'assets/images/google.png',
                                  fit: BoxFit.fill,
                                  width: getWidth(27),
                                ),
                                SizedBox(
                                  width: getWidth(10),
                                ),
                                TextWidget(
                                    text: 'Sign in with google',
                                    color: Colors.white,
                                    isBold: true,
                                    textSize: getFont(22))
                              ],
                            ),
                          )),
                  SizedBox(
                    height: getHeight(20),
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          thickness: 2,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: getWidth(8),
                      ),
                      TextWidget(
                        text: 'OR',
                        color: Colors.white,
                        textSize: getFont(22),
                        isBold: true,
                      ),
                      SizedBox(
                        width: getWidth(8),
                      ),
                      const Expanded(
                        child: Divider(
                          thickness: 2,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getHeight(20),
                  ),
                  AuthButton(
                    onPressed: () {
                      if (controller.isLoadginEmail ||
                          controller.isLoadingSignInGoogle) {
                        appToast("In Authentication Process");
                      } else {
                        Navigator.pushNamedAndRemoveUntil(context,
                            RouteKeys.homeScreen, (route) => false);
                      }
                    },
                    buttonText: 'Continue as a guest',
                    color: Colors.grey.shade300,
                    textColor: Colors.black,
                  ),
                  SizedBox(
                    height: getHeight(20),
                  ),
                  Center(
                    child: RichText(
                        text: TextSpan(
                            text: 'Don\'t have an account?',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: getFont(20),
                              //fontWeight: FontWeight.bold,
                            ),
                            children: [
                          TextSpan(
                              text: '  Sign up',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: getFont(20),
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(
                                      context, RouteKeys.registerScreen);
                                })
                        ])),
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
