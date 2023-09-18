import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../../../../core/utils/size_config.dart';
import '../../../../core/widgets/text_widget.dart';

class ListTileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subTitle;
  final Color? color;
  final void Function() onPressed;
  const ListTileWidget({super.key,required this.icon,required this.color,required this.onPressed,required this.title,this.subTitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      leading: Icon(icon,color: Colors.white,),
      title: TextWidget(text: title,color: color,textSize: getFont(23),),
      subtitle: subTitle==null?null:TextWidget(text:subTitle! ,color: color,textSize: getFont(20),),
      trailing: const Icon(IconlyLight.arrowRight2,color: Colors.white,),
      onTap: onPressed,
    );
  }
}