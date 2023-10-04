import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
 import '../../../../core/utils/size_config.dart';
import '../../../../core/widgets/text_widget.dart';
import '../../../category_products/view/category_product_scren.dart';

class CatItem extends StatelessWidget {
  final String title;
  final String image;
  final String id;
  final Color passedColor;
  const CatItem({
    super.key,
    required this.title,
    required this.image,
    required this.passedColor,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CategoryProductScreen(categoryName: title, categoryId: id),
            ));
      },
      child: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            color: passedColor.withOpacity(.1),borderRadius: BorderRadius.circular(15)
          , boxShadow: [BoxShadow(
            color: passedColor.withOpacity(.2)
           ,
           blurRadius: 3, spreadRadius: 1.5,
          )]
          ),
          child: GridTile(
          
              footer: GridTileBar(
               backgroundColor: passedColor.withOpacity(.4),
                leading: TextWidget(
                  text:  title,
                  color: AppColors.whiteColor,
                  textSize: getFont(22),
                  isBold: true,
                ),
              ),
              child: FancyShimmerImage(
                shimmerBackColor: Colors.grey,
                shimmerHighlightColor: Colors.white,
                boxDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                imageUrl: image,
              ))),
    );
  }
}
