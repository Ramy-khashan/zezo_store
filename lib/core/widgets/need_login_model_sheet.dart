import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/route_key.dart';
import '../utils/size_config.dart';
import 'auth_button.dart';

needLogin({required BuildContext context}) => showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      elevation: 0,
      builder: (context) => Container(
        margin: EdgeInsets.only(top: getHeight(50)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: getWidth(100),
              height: getHeight(9),
              decoration: const BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25))),
            ),
            SizedBox(
              height: getHeight(20),
            ),
            Padding(
              padding: EdgeInsets.all(getWidth(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RouteKeys.loginScreen);
                    },
                    buttonText: "Go to sign in",
                    color: const Color.fromARGB(85, 83, 83, 83),
                  ),
                  SizedBox(
                    height: getHeight(getHeight(15)),
                  ),
                  AppButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RouteKeys.registerScreen);
                    },
                    textColor: Colors.white,
                    buttonText: "Go to sign up",
                    color: const Color.fromARGB(85, 83, 83, 83),
                  ),
                  SizedBox(
                    height: getHeight(20),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
