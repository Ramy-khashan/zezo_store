import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../../modules/home_screen/view/widgets/price_widget.dart';
import '../constants/app_colors.dart';
import '../constants/route_key.dart';
import '../utils/size_config.dart';
 
class OnSaleItem extends StatelessWidget {
  const OnSaleItem(
      {super.key,
      required this.product,
      required this.onTapCart,
      required this.onTapFavorite});
  final QueryDocumentSnapshot<Map<String, dynamic>> product;
  final VoidCallback onTapCart;
  final VoidCallback onTapFavorite;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, RouteKeys.productDetailsScreen,
          arguments: (product.id)),
      child: Container(
        width: 200, 
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: EdgeInsets.all(getWidth(8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    height: getHeight(70),
                    width: getWidth(70),
                    child: FancyShimmerImage(
                      boxFit: BoxFit.fill,
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
                            onTap: onTapFavorite,
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
                  salePrice: product.get("on_sale_price"),
                  price: product.get("price"),
                  isOnSale: product.get("is_on_sale")),
              SizedBox(
                height: getHeight(8),
              ),
              Text(
                product.get("title"),
            overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: AppColors.whiteColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
