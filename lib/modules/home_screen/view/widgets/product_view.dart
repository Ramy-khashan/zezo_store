import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/route_key.dart';
import '../../../../core/widgets/text_widget.dart';
import 'price_widget.dart'; 
class ProductViewItem extends StatelessWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>>  product;
  final VoidCallback onTapCart;
  final VoidCallback onTapFavorite;
  const ProductViewItem({
    super.key,
    required this.product,
    required this.onTapCart,
    required this.onTapFavorite,
  });

  @override
  Widget build(BuildContext context) {
     return GestureDetector(
        onTap: () => Navigator.pushNamed(
            context, RouteKeys.productDetailsScreen,
            arguments: (product.id)),
        child: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            color: AppColors.blackColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: GridTile(
              header: GridTileBar(
                title: Row(
                  children: [
                    CircleAvatar(
                        backgroundColor: AppColors.blackColor.withOpacity(.7),
                        child: GestureDetector(
                            onTap: onTapCart,
                            child: Icon(
                              IconlyLight.buy,
                              size:  28 ,
                              color: Colors.orange,
                            ))),
                    const Spacer(),
                    CircleAvatar(
                        backgroundColor: AppColors.blackColor.withOpacity(.7),
                        child: GestureDetector(
                            onTap: onTapFavorite,
                            child: Icon(
                              IconlyLight.heart,
                              size: 28,
                              color: Colors.orange,
                            )))
                  ],
                ),
              ),
              footer: GridTileBar(
                backgroundColor: AppColors.primaryColor,
                title: TextWidget(
                  text: product.get("title") ,
                  color: Colors.white,
                  isBold: true,
                  textSize:  20 ,
                  maxlines: 1,
                ),
                subtitle: PriceWidget(
                    salePrice:product.get("on_sale_price"),
                    price:product.get("price"),
                    isOnSale: product.get("is_on_sale")),
              ),
              child: FancyShimmerImage(
                  imageUrl: product.get("main_image"))),
        ));
  }
}
