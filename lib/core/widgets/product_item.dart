import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import '../../modules/category_products/model/product_model.dart';
import '../../modules/home_screen/view/widgets/price_widget.dart';
import '../constants/app_colors.dart';
import '../constants/route_key.dart';
import '../utils/functions/camil_case.dart';
import '../utils/size_config.dart';
import 'text_widget.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onTapCart;
  final VoidCallback onTapFavorite;
  const ProductItem({
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
            arguments: (product.fields!.productId!.stringValue)),
        child: Material(
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
                              size: 28,
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
                    backgroundColor: Theme.of(context).primaryColor,
                    title: TextWidget(
                      text:
                          camilCaseMethod(product.fields!.title!.stringValue!),
                      color: Colors.white,
                      isBold: true,
                      textSize: getFont(21),
                      maxlines: 1,
                    ),
                    subtitle: PriceWidget(
                        salePrice: product.fields!.onSalePrice!.stringValue!,
                        price: product.fields!.price!.stringValue!,
                        isOnSale: product.fields!.isOnSale!.booleanValue!),
                  ),
                  product.fields!.isOnSale!.booleanValue!
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
                                "${(100 - (double.parse(product.fields!.onSalePrice!.stringValue.toString()) / double.parse(product.fields!.price!.stringValue.toString())) * 100).floor()}%",
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
                  imageUrl: product.fields!.mainImage!.stringValue!)),
        ));
  }
}
