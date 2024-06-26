import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/widgets/loading_item.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/firestore_keys.dart';
import '../../../core/utils/functions/add_to_favorite.dart'; 
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
              textSize: getFont(26),
              isBold: true,
            ),
          ),
          body:Stack(
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
              BlocBuilder<CategoryProductCubit, CategoryProductState>(
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
                            fontWeight: FontWeight.bold,  ),
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
                                      fontWeight: FontWeight.bold, ),
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
                                                  .get("is_on_sale")? snapshot
                                                  .data!.docs[index]
                                                  .get("on_sale_price"): snapshot
                                                  .data!.docs[index]
                                                  .get("price"),
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
              ),
            ],
          )
          ),
    );
  }
}
