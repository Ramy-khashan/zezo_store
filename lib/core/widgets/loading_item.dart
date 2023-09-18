import 'dart:io';

import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class LoadingItem extends StatelessWidget {
  const LoadingItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isAndroid
          ? CircularProgressIndicator(
              color: AppColors.primaryColor,
              backgroundColor: Colors.grey.withOpacity(.6),
            )
          : Platform.isIOS
              ? const CircularProgressIndicator.adaptive()
              : const LinearProgressIndicator(),
    );
  }
}
