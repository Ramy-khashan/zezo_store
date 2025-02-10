import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../shop_app.dart';

class AppImage {
  // ignore: missing_return
  static Widget? drawImage(String? url,
      {double? height,
      double? width,
      Color? color,
      fit = BoxFit.fill,
      defaultUrl,
      Widget? defaultDesign}) {
    try {
      defaultUrl =
          Theme.of(ShopApp.navigatorKey.currentContext!).brightness.index == 1
              ? "assets/images/zezo.png"
              : "assets/images/zezo_white.png";
      if (url == null) {
        if (defaultDesign != null) {
          return defaultDesign;
        } else {
          if (defaultUrl.toLowerCase().endsWith(".svg")) {
            return SvgPicture.asset(
              defaultUrl,
              width: width,
              height: height,
              fit: BoxFit.contain,
            );
          } else {
            return Image.asset(
              defaultUrl,
              width: width,
              height: height,
              fit: fit,
              color: color,
            );
          }
        }
      } else {
        if (url.startsWith("http")) {
          if (url.toLowerCase().endsWith(".svg")) {
            return SvgPicture.network(
              url,
              width: width,
              height: height,
              fit: fit,
              placeholderBuilder: (context) => Image.asset(
                defaultUrl,
                height: height,
                width: width,
                fit: fit,
              ),
            );
          } else {
            return Image.network(
              url,
              width: width,
              height: height,
              fit: fit,
              color: color,

              // loadingBuilder: (context, child, c) {
              //   if (c == null) return child;
              //   return  LoadingItem();
              // }
              // ,

              errorBuilder: (context, child, error) => Image.asset(
                defaultUrl,
                height: height,
                width: width,
                fit: fit,
              ),
            );
          }
        } else {
          if (url.toLowerCase().endsWith(".svg")) {
            return color == null
                ? SvgPicture.asset(
                    url,
                    width: width,
                    height: height,
                    fit: fit,
                    placeholderBuilder: (context) => Image.asset(
                      defaultUrl,
                      height: height,
                      width: width,
                      fit: fit,
                    ),
                  )
                : SvgPicture.asset(
                    url,
                    width: width,
                    height: height,
                    // color: color,
                    fit: fit,
                    placeholderBuilder: (context) => Image.asset(
                      defaultUrl,
                      height: height,
                      width: width,
                      fit: fit,
                    ),
                  );
          } else if (url.startsWith("assets/images")) {
            return Image.asset(
              url,
              width: width,
              color: color,
              height: height,
              fit: fit,
              errorBuilder: (context, child, error) => Image.asset(
                defaultUrl,
                height: height,
                width: width,
                fit: fit,
              ),
            );
          } else if (url.startsWith("assets/image")) {
            return Image.asset(
              url,
              width: width,
              height: height,
              fit: fit,
              color: color,
              errorBuilder: (context, child, error) => Image.asset(
                defaultUrl,
                height: height,
                width: width,
                fit: fit,
              ),
            );
          } else {
            return Image.file(
              File(url),
              fit: fit,
              errorBuilder: (context, child, error) => Image.asset(
                defaultUrl,
                height: height,
                width: width,
                fit: fit,
              ),
            );
          }
        }
      }
      // ignore: empty_catches
    } catch (e) {}
    return const SizedBox();
  }
}
