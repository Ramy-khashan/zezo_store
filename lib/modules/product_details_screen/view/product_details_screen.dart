import 'package:card_swiper/card_swiper.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/functions/add_to_favorite.dart';
 import '../../../core/utils/size_config.dart';
import '../../../core/widgets/back_icon.dart';
import '../../../core/widgets/icon_button_item.dart';
import '../../../core/widgets/loading_item.dart';
import '../../../core/widgets/text_widget.dart';
import '../../home_screen/view/widgets/price_widget.dart';
import '../controller/product_details_cubit.dart';
import 'widgets/swip_button.dart';

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
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          leading: const BackIcon(),
        ),
        body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            final controller = ProductDetailsCubit.get(context);
            return controller.isLoadingProduct
                ? const LoadingItem()
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          height: getHeight(320),
                          child: Swiper(
                            itemBuilder: (BuildContext context, int index) {
                              return FancyShimmerImage(
                                  imageUrl: controller
                                      .product!
                                      .fields!
                                      .productImage!
                                      .arrayValue!
                                      .values![index]);
                            },
                            autoplay: true,
                            itemCount: controller.product!.fields!.productImage!
                                .arrayValue!.values!.length,
                            pagination: const SwiperPagination(
                                alignment: Alignment.bottomCenter,
                                builder: DotSwiperPaginationBuilder(
                                    color: Colors.white,
                                    activeColor: AppColors.primaryColor)),
                          ),
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
                                    child: Text (
                                        controller.product!
                                            .fields!.title!.stringValue!,
                                            overflow: TextOverflow.clip,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: getFont(28)
                                        ),),
                                  ),
                                   
                                  IconButtonItem(
                                      icon: IconlyLight.heart,
                                      color: AppColors.whiteColor,
                                      onPressed: () async {
                                        await addTofavorite(
                                          userId: controller.userId,
                                          productId: controller.product!.fields!
                                              .productId!.stringValue!,
                                          productImg: controller.product!
                                              .fields!.mainImage!.stringValue!,
                                          productPrice: controller.product!
                                              .fields!.title!.stringValue!,
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
                                        color: Colors.grey.shade300,
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
                                  color: Colors.grey.shade300,
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
                                             color: Colors.white,
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
                                          color: Colors.grey.shade300,
                                          textSize: getFont(26)),
                                      const Spacer(),
                                      CircleAvatar(
                                        backgroundColor: Colors.grey.shade200,
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
                                              color: AppColors.whiteColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: getFont(25)),
                                        ),
                                      ),
                                      CircleAvatar(
                                        backgroundColor: Colors.grey.shade200,
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
                                  child: SwipeableButtonView(
                                      onWaitingProcess: () async {
                                        controller.isAccepted = true;
                                        controller.isLoadingAddCart = true;
                                        await controller.addToCart();
                                      },
                                      backgroundColor: Colors.grey.shade700,
                                      buttonWidget: const Icon(
                                        Icons.shopping_cart_outlined,
                                        color: Colors.black,
                                      ),
                                      backWidget: const Icon(
                                        Icons.shopping_cart_checkout_outlined,
                                        color: Colors.white,
                                      ),
                                      isAccepted: controller.isAccepted,
                                      isWaiting: controller.isLoadingAddCart),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
