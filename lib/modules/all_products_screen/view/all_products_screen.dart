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
                  ),
                ),
                centerTitle: true,
                title: TextWidget(
                  text: 'All Products',
                  textSize: getFont(30),
                  isBold: true,
                ),
                bottom: PreferredSize(
                    preferredSize: Size(double.infinity, getHeight(55)),
                    child: TextFormField(
                      onChanged: (String val) {
                        controller.onPressedSearch(val);
                      },
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
                        ),
                        hintText: 'What\'s in your mind?',
                        // suffixIcon: IconButton(
                        //     onPressed: (){},
                        //     icon: Icon(
                        //       Icons.menu,
                        //       color: Colors.white,

                        //     ))
                      ),
                    )),
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
                  RefreshIndicator(
                    onRefresh: () async {
                      await controller.getProduct();
                    },
                    child: Center(
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
                                      ),
                                    ),
                                    SizedBox(
                                      height: getHeight(10),
                                    ),
                                    CircleAvatar(
                                      backgroundColor: Theme.of(context).primaryColor,
                                      child: IconButton(
                                          onPressed: () async {
                                            await controller.getProduct();
                                          },
                                          icon: Icon(
                                            Icons.refresh,
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
                                      ),
                                    )
                                  : controller.serarchCount == 0
                                      ? Text(
                                          camilCaseMethod(
                                              "No product with this name"),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: getFont(25),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      : GridView.builder(
                                          padding: const EdgeInsets.all(5),
                                          gridDelegate:
                                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                                  maxCrossAxisExtent: 200,
                                                  mainAxisExtent: 260,
                                                  crossAxisSpacing: 17,
                                                  mainAxisSpacing: 20),
                                          itemCount: controller.product.length,
                                          itemBuilder: (context, index) =>
                                              ProductItem(
                                            onTapCart: () {
                                              controller.addToCart(
                                                  controller.product[index]);
                                            },
                                            product: controller.product[index],
                                            onTapFavorite: () async {
                                              await addTofavorite(
                                                  userId: controller.userId!,
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
                                                          .isOnSale!
                                                          .booleanValue!
                                                      ? controller
                                                          .product[index]
                                                          .fields!
                                                          .onSalePrice!
                                                          .stringValue!
                                                      : controller
                                                          .product[index]
                                                          .fields!
                                                          .price!
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
                  ),
                ],
              ));
        },
      ),
    );
  }
}
