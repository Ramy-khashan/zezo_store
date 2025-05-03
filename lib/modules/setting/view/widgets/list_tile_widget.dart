import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:store/core/widgets/loading_item.dart';

import '../../../../core/utils/size_config.dart';
import '../../../../core/widgets/text_widget.dart';

class ListTileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isLoading;
  final String? subTitle;
  final void Function() onPressed;
  const ListTileWidget({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.title,
    this.subTitle,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      leading: isLoading ? SizedBox.shrink() : Icon(icon),
      title: isLoading
          ? LoadingItem()
          : TextWidget(
              text: title,
              textSize: getFont(23),
            ),
      subtitle: subTitle == null
          ? null
          : isLoading
              ? SizedBox.shrink()
              : TextWidget(
                  text: subTitle!,
                  textSize: getFont(20),
                ),
      trailing: isLoading
          ? SizedBox.shrink()
          : const Icon(
              IconlyLight.arrowRight2,
            ),
      onTap: isLoading ? null : onPressed,
    );
  }
}
