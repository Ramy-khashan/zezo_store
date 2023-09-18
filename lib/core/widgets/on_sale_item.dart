import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

 import '../../modules/home_screen/view/widgets/price_widget.dart';
import '../constants/app_colors.dart';
import '../constants/route_key.dart';
import '../utils/size_config.dart';
import 'text_widget.dart';

class OnSaleItem extends StatelessWidget {
  const OnSaleItem({super.key, required this.product, required this.onTapCart, required this.onTapFavorite});
  final QueryDocumentSnapshot<Map<String, dynamic>> product;
  final VoidCallback onTapCart;
  final VoidCallback onTapFavorite;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, RouteKeys.productDetailsScreen,
          arguments: (product.id)),
      child: Material(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        borderRadius: BorderRadius.circular(12),
        color: AppColors.primaryColor,
        child: Padding(
          padding: EdgeInsets.all(getWidth(8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: getHeight(70),
                    width: getWidth(70),
                    child: FancyShimmerImage(
                      boxDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      imageUrl: product.get("main_image"),
                    ),
                  ),
                  SizedBox(
                    width: getWidth(8),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: onTapCart,
                            child: Icon(
                              IconlyLight.bag2,
                              color: AppColors.whiteColor,
                              size: getWidth(22),
                            ),
                          ),
                          SizedBox(
                            width: getWidth(5),
                          ),
                          GestureDetector(
                            onTap:onTapFavorite,
                            child: Icon(
                              IconlyLight.heart,
                              color: AppColors.whiteColor,
                              size: getWidth(22),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: getHeight(8),
              ),
              PriceWidget(
                                 salePrice:product.get("on_sale_price"),
                    price:product.get("price"),
                    isOnSale: product.get("is_on_sale")) 
               ,
              SizedBox(
                height: getHeight(8),
              ),
              TextWidget(
                text: product.get("title"),
                color: AppColors.whiteColor,
                textSize: getFont(25),
                isBold: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}
