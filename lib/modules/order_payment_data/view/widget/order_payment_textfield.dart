import 'package:flutter/material.dart';
 import '../../../../core/utils/size_config.dart';

class OrderPaymentTextfieldItem extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType textInputType;
  final Function(dynamic val) validate;
  const OrderPaymentTextfieldItem(
      {super.key,
      required this.controller,
      required this.hint,
      required this.textInputType,
      required this.validate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getHeight(7)),
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        validator: (value) => validate(value),
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: hint,
          labelStyle: const TextStyle(color: Colors.white),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.white)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.white)),
        ),
      ),
    );
  }
}
