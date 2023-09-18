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
                              size: 28,
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
                  text: camilCaseMethod(product.fields!.title!.stringValue!),
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
              child: FancyShimmerImage(
                  imageUrl: product.fields!.mainImage!.stringValue!)),
        ));
  }
}
