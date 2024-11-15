import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_colors.dart';
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

            return Stack(
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
                SingleChildScrollView(
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
                        textSize: getFont(35),
                        isBold: true,
                      ),
                      SizedBox(
                        height: getHeight(10),
                      ),
                      TextWidget(
                        text: 'Sign in to continue',
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
                          : AppButton(
                              onPressed: () {
                                controller.isLoadingSignInGoogle
                                    ? appToast("In Authentication Process")
                                    : controller.onSubmitLogin(context);
                              },
                              buttonText: 'Login',
                              color: Colors.grey),
                      SizedBox(
                        height: getHeight(20),
                      ),
                      controller.isLoadingSignInGoogle
                          ? const LoadingItem()
                          : AppButton(
                              onPressed: () {
                                Platform.isAndroid
                                    ? (controller.isLoadginEmail
                                        ? appToast("In Authentication Process")
                                        : controller.signInWithGoogle(context))
                                    : controller.signInWithApple();
                              },
                              color:
                                  Platform.isIOS ? Colors.black : Colors.grey,
                              child: Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      Platform.isIOS
                                          ? "assets/images/apple.png"
                                          : 'assets/images/google.png',
                                      color:
                                          Platform.isIOS ? Colors.white : null,
                                      fit: BoxFit.fill,
                                      width: getWidth(27),
                                    ),
                                    SizedBox(
                                      width: getWidth(10),
                                    ),
                                    Text(
                                      Platform.isIOS
                                          ? 'Sign in with apple'
                                          : 'Sign in with google',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 17),
                                    )
                                  ],
                                ),
                              )),
                      SizedBox(
                        height: getHeight(20),
                      ),
                      // AppButton(
                      //     onPressed: () {
                      //       controller.isLoadginEmail
                      //           ? appToast("In Authentication Process")
                      //           : controller.signInWithFacebook(context);
                      //     },
                      //         color: Colors.grey,
                      //     child: Center(
                      //       child: Row(
                      //         mainAxisSize: MainAxisSize.min,
                      //         children: [
                      //           const Icon(Icons.facebook_outlined,size: 30,),
                      //           SizedBox(
                      //             width: getWidth(10),
                      //           ),
                      //           const Text(
                      //                'Sign in with facebook',
                      //                style: TextStyle(
                      //                     color: Colors.white,
                      //                     fontWeight: FontWeight.w900,
                      //                     fontSize: 18),)
                      //         ],
                      //       ),
                      //     )),
                      // SizedBox(
                      //   height: getHeight(20),
                      // ),
                      Row(
                        children: [
                          const Expanded(
                            child: Divider(
                              thickness: 2,
                              // color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: getWidth(8),
                          ),
                          const Text(
                            'OR',
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 18),
                          ),
                          SizedBox(
                            width: getWidth(8),
                          ),
                          const Expanded(
                            child: Divider(
                              thickness: 2,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: getHeight(20),
                      ),
                      AppButton(
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
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: getHeight(20),
                      ),
                      Center(
                          child: Text.rich(
                        TextSpan(children: [
                          const TextSpan(
                            text: 'Don\'t have an account?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
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
                        ]),
                      ))
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
