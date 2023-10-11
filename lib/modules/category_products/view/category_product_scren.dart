import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/widgets/loading_item.dart';
import '../../../core/constants/firestore_keys.dart';
import '../../../core/utils/functions/add_to_favorite.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/functions/camil_case.dart';
import '../../../core/utils/size_config.dart';
import '../../../core/widgets/back_icon.dart';
import '../../../core/widgets/text_widget.dart';
import '../../home_screen/view/widgets/product_view.dart';
import '../controller/category_product_cubit.dart';

class CategoryProductScreen extends StatelessWidget {
  const CategoryProductScreen(
      {super.key, required this.categoryName, required this.categoryId});
  final String categoryName;
  final String categoryId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryProductCubit()..getUSerDetails(),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            centerTitle: true,
            leading: const BackIcon(),
            title: TextWidget(
              text: camilCaseMethod(categoryName),
              color: AppColors.whiteColor,
              textSize: getFont(26),
              isBold: true,
            ),
          ),
          body: BlocBuilder<CategoryProductCubit, CategoryProductState>(
            builder: (context, state) {
              final controller = CategoryProductCubit.get(context);
              return FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection(FirestoreKeys.proucts)
                    .where("category", isEqualTo: categoryId)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        camilCaseMethod("Something went wrong try again!"),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: getFont(25),
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    return snapshot.data!.docs.isEmpty
                        ? Center(
                          child: Text(
                              camilCaseMethod(
                                  "No Products available for this category for now."),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: getFont(25),
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.whiteColor),
                            ),
                        )
                        : GridView.builder(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(13),
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 200,
                                          mainAxisExtent: 270,
                                          childAspectRatio: 3 / 2,
                                          crossAxisSpacing: 17,
                                          mainAxisSpacing: 20),
                                          itemCount:  snapshot.data!.docs.length > 8
                                    ? 8
                                    : snapshot.data!.docs.length,
                          itemBuilder: (context, index) => 
                            ProductViewItem(
                                      onTapCart: () async {
                                        await controller.addToCart(
                                            snapshot.data!.docs[index]);
                                      },
                                      product: snapshot.data!.docs[index],
                                      onTapFavorite: () async {
                                        await addTofavorite(
                                          userId: controller.userId!,
                                          productId:
                                              snapshot.data!.docs[index].id,
                                          productImg: snapshot
                                              .data!.docs[index]
                                              .get("main_image"),
                                          productPrice: snapshot
                                              .data!.docs[index]
                                              .get("on_sale_price"),
                                          productTitle: snapshot
                                              .data!.docs[index]
                                              .get("title"),
                                        );
                                      },
                                    ));
                       
                  }
                  return const LoadingItem();
                },
              );
            },
          )
          // BlocBuilder<CategoryProductCubit, CategoryProductState>(
          //   builder: (context, state) {
          //     final controller = CategoryProductCubit.get(context);
          //     return Padding(
          //       padding: EdgeInsets.all(getWidth(10)),
          //       child: Center(
          //         child: controller.isLoadingProducts
          //             ? const LoadingItem()
          //             : controller.isFaild
          //                 ? Column(
          //                     mainAxisSize: MainAxisSize.min,
          //                     children: [
          //                       Text(
          //                         camilCaseMethod(
          //                             "Something went wrong try again!"),
          //                         textAlign: TextAlign.center,
          //                         style: TextStyle(
          //                             fontSize: getFont(25),
          //                             fontWeight: FontWeight.bold,
          //                             color: AppColors.whiteColor),
          //                       ),
          //                       SizedBox(
          //                         height: getHeight(10),
          //                       ),
          //                       CircleAvatar(
          //                         backgroundColor: AppColors.primaryColor,
          //                         child: IconButton(
          //                             onPressed: () async {
          //                               await controller.getproduct(
          //                                   id: categoryId);
          //                             },
          //                             icon: Icon(
          //                               Icons.refresh,
          //                               color: Colors.white,
          //                               size: getWidth(25),
          //                             )),
          //                       )
          //                     ],
          //                   )
          //                 : controller.allProduct.isEmpty
          //                     ? Text(
          //                         camilCaseMethod(
          //                             "No product available right now, Come back later!"),
          //                         textAlign: TextAlign.center,
          //                         style: TextStyle(
          //                             fontSize: getFont(25),
          //                             fontWeight: FontWeight.bold,
          //                             color: AppColors.whiteColor),
          //                       )
          //                     : GridView.count(
          //                         crossAxisCount: 2,
          //                         childAspectRatio: 8 / 9,
          //                         mainAxisSpacing: 13,
          //                         crossAxisSpacing: 10,
          //                         physics: const BouncingScrollPhysics(),
          //                         children: List.generate(
          //                             controller.product.length,
          //                             (index) => ProductItem(
          //                                   onTapCart: () {
          //                                     controller.addToCart(
          //                                         controller.product[index]);
          //                                   },
          //                                   product: controller.product[index],
          //                                   onTapFavorite: () {
          //                                     addTofavorite(
          //                                         userId: controller.userId,
          //                                         productId: controller
          //                                             .product[index]
          //                                             .fields!
          //                                             .productId!
          //                                             .stringValue!,
          //                                         productImg: controller
          //                                             .product[index]
          //                                             .fields!
          //                                             .mainImage!
          //                                             .stringValue!,
          //                                         productPrice: controller
          //                                             .product[index]
          //                                             .fields!
          //                                             .title!
          //                                             .stringValue!,
          //                                         productTitle: controller
          //                                             .product[index]
          //                                             .fields!
          //                                             .price!
          //                                             .stringValue!);
          //                                   },
          //                                 )),
          //                       ),
          //       ),
          //     );
          //   },
          // ),

          ),
    );
  }
}
