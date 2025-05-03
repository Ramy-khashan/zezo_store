import 'package:flutter/material.dart';

class ImageHandler extends StatelessWidget {
  const ImageHandler(
    this.image, {
    super.key,
    this.width,
    this.height, this.boxFit,
  });
  final String image;
  final double? width;
  final double? height;
  final BoxFit? boxFit;
  @override
  Widget build(BuildContext context) {
    return Image.network(
      image,
      width: width,
      height: height,
      fit:boxFit,
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) =>
              Image.asset(
        Theme.of(context).brightness.index == 0
            ? "assets/images/zezo_white.png"
            : "assets/images/zezo.png",
          fit: BoxFit.fill,
       
      ),
    );
  }
}
