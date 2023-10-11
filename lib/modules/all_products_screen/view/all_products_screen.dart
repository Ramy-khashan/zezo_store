import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/functions/add_to_favorite.dart';
import '../../../core/utils/functions/app_toast.dart';
import '../../../core/utils/functions/camil_case.dart';
import '../../../core/utils/size_config.dart';
import '../../../core/widgets/loading_item.dart';
import '../../../core/widgets/product_item.dart';
import '../../../core/widgets/text_widget.dart';
import '../controller/all_products_cubit.dart';

class AllProductScreen extends StatelessWidget {
  const AllProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider<AllProductsCubit>(
      create: (_) => AllProductsCubit()..getUSerDetails(),
      child: BlocConsumer<AllProductsCubit, AllProductsState>(
        listener: (context, state) {
          if (state is FailedGetAllProductState) {
            appToast(state.error);
          }
        },
        builder: (context, state) {
          final controller = AllProductsCubit.get(context);

          return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                leading: InkWell(
                  onTap: () => Navigator.pop(context),
                  borderRadius: BorderRadius.circular(12),
                  child: const Icon(
                    IconlyLight.arrowLeft2,
                    color: AppColors.whiteColor,
                  ),
                ),
                centerTitle: true,
                title: TextWidget(
                  text: 'All Products',
                  color: AppColors.whiteColor,
                  textSize: getFont(30),
                  isBold: true,
                ),
                bottom: PreferredSize(
                    preferredSize: Size(double.infinity, getHeight(55)),
                    child: TextFormField(
                      onChanged: (String val) {
                        controller.onPressedSearch(val);
                      },
                      style: const TextStyle(color: AppColors.whiteColor),
                      decoration: InputDecoration(
                        isDense: true,
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Colors.green, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Colors.green, width: 1),
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: AppColors.whiteColor,
                        ),
                        hintText: 'What\'s in your mind?',
                        hintStyle: const TextStyle(color: AppColors.whiteColor),
                        // suffixIcon: IconButton(
                        //     onPressed: controller.onPressedSearch,
                        //     icon: Icon(
                        //       Icons.close,
                        //       color: controller.searchFocus.hasFocus
                        //           ? Colors.red.shade300
                        //           : AppColors.whiteColor,
                        //     ))
                      ),
                    )),
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  await controller.getProduct();
                },
                child:  Center(
                    child: controller.isLoadingProducts
                        ? const LoadingItem()
                        : controller.isFaild
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    camilCaseMethod(
                                        "Something went wrong try again!"),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: getFont(25),
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.whiteColor),
                                  ),
                                  SizedBox(
                                    height: getHeight(10),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: AppColors.primaryColor,
                                    child: IconButton(
                                        onPressed: () async {
                                          await controller.getProduct();
                                        },
                                        icon: Icon(
                                          Icons.refresh,
                                          color: Colors.white,
                                          size: getWidth(25),
                                        )),
                                  )
                                ],
                              )
                            : controller.allProduct.isEmpty
                                ? Text(
                                    camilCaseMethod(
                                        "No product available right now, Come back later!"),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: getFont(25),
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.whiteColor),
                                  )
                                : controller.serarchCount == 0
                                    ? Text(
                                        camilCaseMethod(
                                            "No product with this name"),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: getFont(25),
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.whiteColor),
                                      )
                                    :   GridView.builder(  
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 200,
                                          mainAxisExtent: 260, 
                                          crossAxisSpacing: 17,
                                          mainAxisSpacing: 20),
                                          itemCount:   controller.product.length,
                                          itemBuilder:(context, index) =>   ProductItem(
                                          onTapCart: () {
                                            controller.addToCart(
                                                controller
                                                    .product[index]);
                                          },
                                          product:
                                              controller.product[index],
                                          onTapFavorite: () async {
                                            await addTofavorite(
                                                userId:
                                                    controller.userId!,
                                               productId: controller
                                            .product[index]
                                            .fields!
                                            .productId!
                                            .stringValue!,
                                        productImg: controller
                                            .product[index]
                                            .fields!
                                            .mainImage!
                                            .stringValue!,
                                        productPrice: controller
                                            .product[index]
                                            .fields!
                                            .title!
                                            .stringValue!,
                                        productTitle: controller
                                            .product[index]
                                            .fields!
                                            .price!
                                            .stringValue!);
                                          },
                                        ),
                                      ),
                                          
                                          
                                       
                  ),
               
              ));
        },
      ),
    );
  }
}
