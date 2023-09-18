import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/api/dio_consumer.dart';
import '../../../core/utils/functions/add_to_favorite.dart';
import '../../../core/utils/functions/locator_service.dart';
import '../../../core/widgets/loading_item.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/functions/camil_case.dart';
import '../../../core/utils/size_config.dart';
import '../../../core/widgets/back_icon.dart';
import '../../../core/widgets/product_item.dart';
import '../../../core/widgets/text_widget.dart';
import '../controller/category_product_cubit.dart';

class CategoryProductScreen extends StatelessWidget {
  const CategoryProductScreen(
      {super.key, required this.categoryName, required this.categoryId});
  final String categoryName;
  final String categoryId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CategoryProductCubit(serviceLocator.get<DioConsumer>())
            ..getproduct(id: categoryId)
            ..getUSerDetails(),
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
            return Padding(
              padding: EdgeInsets.all(getWidth(10)),
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
                                    color: AppColors.whiteColor),
                              ),
                              SizedBox(
                                height: getHeight(10),
                              ),
                              CircleAvatar(
                                backgroundColor: AppColors.primaryColor,
                                child: IconButton(
                                    onPressed: () async {
                                      await controller.getproduct(
                                          id: categoryId);
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
                            : GridView.count(
                                crossAxisCount: 2,
                                childAspectRatio: 8 / 9,
                                mainAxisSpacing: 13,
                                crossAxisSpacing: 10,
                                physics: const BouncingScrollPhysics(),
                                children: List.generate(
                                    controller.product.length,
                                    (index) => ProductItem(
                                          onTapCart: () {
                                            controller.addToCart(
                                                controller.product[index]);
                                          },
                                          product: controller.product[index],
                                          onTapFavorite: () {
                                            addTofavorite(
                                                userId: controller.userId,
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
                                        )),
                              ),
              ),
            );
          },
        ),
      ),
    );
  }
}
