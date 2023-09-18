import 'package:flutter/material.dart';

import '../utils/size_config.dart';

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
  const TextFieldItem(
      {super.key,
      this.validator,
      required this.textInputAction,
      required this.textInputType,
      this.obscureText = false,
      required this.hintText,
      this.onTap,
      this.suffixIcon,
      this.focusNode,
      this.verticalPadding,
      this.raduis=25,
      this.onEditingComplete,
      this.controller,
      this.textAlign = TextAlign.start,
      this.maxlines = 1, this.prefexIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:   EdgeInsets.symmetric(vertical:verticalPadding??0),
      child: TextFormField(
        textInputAction: textInputAction,
        maxLines: maxlines,
        textAlign: textAlign,
        keyboardType: textInputType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        focusNode: focusNode,
        controller: controller,
        validator: validator,
        onEditingComplete: onEditingComplete,
        obscureText: obscureText,
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          isDense: true,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.white,
          ),
          border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(raduis)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(raduis)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(raduis)),
          suffixIcon: GestureDetector(
            onTap: onTap,
            child: Icon(
              suffixIcon,
              color: Colors.white,
            ),
          ), prefixIcon: GestureDetector(
            onTap: onTap,
            child: Icon(
              
              prefexIcon,
              size: getWidth(26),
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
