import 'package:flutter/material.dart';
import '../../../../core/utils/size_config.dart';

class OrderPaymentTextfieldItem extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int? lines;
  final TextInputType textInputType;
  final Function(dynamic val) validate;
  const OrderPaymentTextfieldItem(
      {super.key,
      required this.controller,
      this.lines,
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
        maxLines: lines,
        validator: (value) => validate(value),
        decoration: InputDecoration(
          labelText: hint,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.grey)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.grey)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.grey)),
        ),
      ),
    );
  }
}
