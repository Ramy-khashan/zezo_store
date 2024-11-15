import 'package:card_swiper/card_swiper.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:store/core/widgets/auth_button.dart';
 
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/functions/add_to_favorite.dart';
import '../../../core/utils/size_config.dart';
import '../../../core/widgets/back_icon.dart';
import '../../../core/widgets/icon_button_item.dart';
import '../../../core/widgets/loading_item.dart';
import '../../../core/widgets/text_widget.dart';
import '../../home_screen/view/widgets/price_widget.dart';
import '../controller/product_details_cubit.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String prouctId;
  const ProductDetailsScreen({super.key, required this.prouctId});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailsCubit()
        ..getProduct(prouctId)
        ..getUSerDetails(),
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const BackIcon(),
        ),
        body: Stack(
            children: [
              Center(
                child: Image.asset(
                  "assets/images/zezo_white.png",
                  color: Theme.of(context).brightness.index == 0
                      ? Colors.white.withOpacity(.2)
                      : AppColors.blackColor.withOpacity(.1),
                  height: 600,
                  width: 500,
                  fit: BoxFit.cover,
                 ),
              ),
            BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
              builder: (context, state) {
                final controller = ProductDetailsCubit.get(context);
                return controller.isLoadingProduct
                    ? const LoadingItem()
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Material(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  elevation: 5,
                                  child: SizedBox(
                                    height: 320,
                                    child: Swiper(
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return FancyShimmerImage(
                                            imageUrl: controller
                                                .product!
                                                .fields!
                                                .productImage!
                                                .arrayValue!
                                                .values![index]);
                                      },
                                      autoplay: true,
                                      itemCount: controller.product!.fields!
                                          .productImage!.arrayValue!.values!.length,
                                      pagination:   SwiperPagination(
                                          alignment: Alignment.bottomCenter,
                                          builder: DotSwiperPaginationBuilder(
                                              activeColor:  Theme.of(context).primaryColor,)),
                                    ),
                                  ),
                                ),
                                controller.product!.fields!.isOnSale!.booleanValue!
                                    ? Container(
                                        width: 80,
                                        height: 35,
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
                                            "${(100 - (double.parse(controller.product!.fields!.onSalePrice!.stringValue.toString()) / double.parse(controller.product!.fields!.price!.stringValue.toString())) * 100).floor()}%",
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                            SizedBox(
                              height: getHeight(30),
                            ),
                            Padding(
                              padding: EdgeInsets.all(getWidth(8.0)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          controller
                                              .product!.fields!.title!.stringValue!,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: getFont(28)),
                                        ),
                                      ),
                                      IconButtonItem(
                                          icon: IconlyLight.heart,
                                          onPressed: () async {
                                            await addTofavorite(
                                              userId: controller.userId,
                                              productId: controller.product!.fields!
                                                  .productId!.stringValue!,
                                              productImg: controller.product!
                                                  .fields!.mainImage!.stringValue!,
                                              productPrice: controller.product!
                                                  .fields!.isOnSale!.booleanValue!?  controller.product!
                                                  .fields!.onSalePrice!.stringValue!:controller.product!
                                                  .fields!.price!.stringValue!,
                                              productTitle: controller.product!
                                                  .fields!.price!.stringValue!,
                                            );
                                          }),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: getHeight(15)),
                                    child: Row(
                                      children: [
                                        TextWidget(
                                            text: "Price : ",
                                            isBold: true,
                                            textSize: getFont(26)),
                                        PriceWidget(
                                            salePrice: controller.product!.fields!
                                                .onSalePrice!.stringValue!,
                                            price: controller.product!.fields!
                                                .price!.stringValue!,
                                            isOnSale: controller.product!.fields!
                                                .isOnSale!.booleanValue!),
                                      ],
                                    ),
                                  ),
                                  TextWidget(
                                      text: "Description",
                                      isBold: true,
                                      textSize: getFont(26)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          controller.product!.fields!.description!
                                              .stringValue!,
                                          textAlign: TextAlign.right,
                                          textDirection: TextDirection.rtl,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                            fontSize: getFont(23),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: getHeight(15)),
                                    child: Center(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextWidget(
                                              text: "Quantity : ",
                                              isBold: true,
                                              textSize: getFont(26)),
                                          const Spacer(),
                                          CircleAvatar(
                                            child: IconButton(
                                                onPressed: controller.qunatityMuins,
                                                icon: const Icon(Icons.remove)),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: getWidth(15)),
                                            child: Text(
                                              controller.quantaty.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: getFont(25)),
                                            ),
                                          ),
                                          CircleAvatar(
                                            child: IconButton(
                                                onPressed: controller.qunatityPlus,
                                                icon: const Icon(Icons.add)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: getHeight(10)),
                                    child: Center(
                                        child: controller.isLoadingAddCart
                                            ? const LoadingItem()
                                            : AppButton(
                                                onPressed: () async {
                                                  await controller.addToCart();
                                                },
                                                color:Theme.of(context).primaryColor,
                                                buttonText: "Add To Cart",
                                              )),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
