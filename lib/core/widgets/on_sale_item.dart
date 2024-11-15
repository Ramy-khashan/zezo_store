import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import '../../modules/home_screen/view/widgets/price_widget.dart';
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
      child: Material(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 10, 
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(getWidth(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        height: getHeight(70),
                        width: 100,
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
                  Container(
                    constraints: const BoxConstraints(maxWidth: 250),
                    child: Text(
                      product.get("title"),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
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
                              topLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12))),
                      child: Center(
                        child: Text(
                          "${(100 - (double.parse(product.get("on_sale_price").toString()) / double.parse(product.get("price").toString())) * 100).floor()}%",
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
