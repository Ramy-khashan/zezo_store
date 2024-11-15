import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

 
class BackIcon extends StatelessWidget {
  const BackIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.canPop(context) ? Navigator.pop(context) : null,
      borderRadius: BorderRadius.circular(12),
      child: const Icon(
        IconlyLight.arrowLeft2,
        // color: AppColors.whiteColor,
      ),
    );
  }
}
