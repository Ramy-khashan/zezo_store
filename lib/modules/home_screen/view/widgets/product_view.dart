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
        child:  Material(
          clipBehavior: Clip.antiAliasWithSaveLayer,
 elevation: 10,
            color: AppColors.blackColor,
            borderRadius: BorderRadius.circular(15),
          
          child: GridTile(
              header: GridTileBar(
                title: Row(
                  children: [
                    CircleAvatar(
                        backgroundColor: AppColors.blackColor.withOpacity(.7),
                        child: GestureDetector(
                            onTap: onTapCart,
                            child: const Icon(
                              IconlyLight.buy,
                              size:  28 ,
                              color: Colors.orange,
                            ))),
                    const Spacer(),
                    CircleAvatar(
                        backgroundColor: AppColors.blackColor.withOpacity(.7),
                        child: GestureDetector(
                            onTap: onTapFavorite,
                            child: const Icon(
                              IconlyLight.heart,
                              size: 28,
                              color: Colors.orange,
                            )))
                  ],
                ),
              ),
              footer: Stack(
                children: [
                  GridTileBar(
                    backgroundColor:Theme.of(context).primaryColor,
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
            product.get("is_on_sale")
                      ? Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                            width: 50,
                            height: 25,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 5,
                                      spreadRadius: 1,
                                      color: Colors.black54,
                                      offset: Offset(2, 2))
                                ],
                                color: Colors.red,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15))),
                            child: Center(
                              child: Text(
                                "${(100 - (double.parse(product.get("on_sale_price").toString()) / double.parse(product.get("price").toString())) * 100).floor()}%",
                                style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                      )
                      : const SizedBox(),
                ],
              ),
              child: FancyShimmerImage(
                  imageUrl: product.get("main_image"))),
        ));
  }
}
