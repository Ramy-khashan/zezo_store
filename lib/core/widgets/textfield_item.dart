import 'package:flutter/material.dart';

import '../../shop_app.dart';

class TextFieldItem extends StatelessWidget {
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final bool obscureText;
  final FocusNode? focusNode;
  final TextAlign textAlign;
  final int? maxlines;
  final double? verticalPadding;
  final double raduis;
  final String? Function(String?)? validator;
  final void Function()? onEditingComplete;
  final TextEditingController? controller;
  final String hintText;
  final void Function()? onTap;
  final IconData? suffixIcon;
  final IconData? prefexIcon;
  TextFieldItem(
      {super.key,
      this.validator,
      this.textInputAction = TextInputAction.next,
      this.textInputType = TextInputType.emailAddress,
      this.obscureText = false,
      required this.hintText,
      this.onTap,
      this.suffixIcon,
      this.focusNode,
      this.verticalPadding,
      this.raduis = 25,
      this.onEditingComplete,
      this.controller,
      this.textAlign = TextAlign.start,
      this.maxlines = 1,
      this.prefexIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 0),
      child: TextFormField(
        textInputAction: textInputAction,
        maxLines: maxlines,
        textAlign: textAlign,
        keyboardType: textInputType,
        focusNode: focusNode,
        controller: controller,
        validator: validator,
        onEditingComplete: onEditingComplete,
        obscureText: obscureText,
        style: TextStyle(
          color:
              Theme.of(ShopApp.navigatorKey.currentContext!).brightness.index ==
                      1
                  ? Colors.black
                  : Colors.white,
        ),
        decoration: InputDecoration(
          isDense: true,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Theme.of(ShopApp.navigatorKey.currentContext!)
                        .brightness
                        .index ==
                    1
                ? Colors.black
                : Colors.white,
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(ShopApp.navigatorKey.currentContext!)
                            .brightness
                            .index ==
                        1
                    ? Colors.black
                    : Colors.white,
              ),
              borderRadius: BorderRadius.circular(raduis)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(ShopApp.navigatorKey.currentContext!)
                            .brightness
                            .index ==
                        1
                    ? Colors.black
                    : Colors.white,
              ),
              borderRadius: BorderRadius.circular(raduis)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(ShopApp.navigatorKey.currentContext!)
                            .brightness
                            .index ==
                        1
                    ? Colors.black
                    : Colors.white,
              ),
              borderRadius: BorderRadius.circular(raduis)),
          suffixIcon:suffixIcon==null?null:  GestureDetector(
            onTap: onTap,
            child:Icon(
              suffixIcon,
              color: Theme.of(ShopApp.navigatorKey.currentContext!)
                          .brightness
                          .index ==
                      1
                  ? Colors.black
                  : Colors.white,
            ),
          ),
          prefixIcon:prefexIcon==null?null:  GestureDetector(
            onTap: onTap,
            child: Icon(
              prefexIcon,
              size: 26,
              color: Theme.of(ShopApp.navigatorKey.currentContext!)
                          .brightness
                          .index ==
                      1
                  ? Colors.black
                  : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
