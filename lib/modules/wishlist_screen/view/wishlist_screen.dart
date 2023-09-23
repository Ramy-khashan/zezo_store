 
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/route_key.dart';
import '../../../core/utils/functions/camil_case.dart';
import '../../../core/utils/size_config.dart';
import '../../../core/widgets/back_icon.dart';
import '../../../core/widgets/empty_screen.dart';
import '../../../core/widgets/loading_item.dart';
import '../../../core/widgets/text_widget.dart';
import '../controller/wishlist_cubit.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WishlistCubit()..getUserDetails(),
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: const BackIcon(),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            centerTitle: true,
            title: TextWidget(
              text: 'WishList',
              color: AppColors.whiteColor,
              textSize: getFont(24),
              isBold: true,
            ),
          ),
          body: BlocBuilder<WishlistCubit, WishlistState>(
              builder: (context, state) {
            final controller = WishlistCubit.get(context);
            return controller.userId == null
                ? const LoadingItem()
                : StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("favorite")
                        .doc(controller.userId)
                        .collection("favorite_products")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.docs.isEmpty) {
                          return const EmptyScreen(
                            imagePath: 'assets/images/wishlist.png',
                            headText: 'Your wishlist is empty!',
                            text: 'Explore more and shortlist some items',
                            textButton: 'Add a wish',
                          );
                        } else {
                          return GridView.builder(
                              padding: EdgeInsets.all(getWidth(7)),
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 200,
                                      childAspectRatio: 3.4 / 4,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 20),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RouteKeys.productDetailsScreen,
                                        arguments: (snapshot.data!.docs[index]
                                            .get("product_id")));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.blackColor,
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                              color: AppColors.whiteColor
                                                  .withOpacity(.5),
                                              blurRadius: 6,
                                              spreadRadius: 1)
                                        ]),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: GridTile(
                                      header: GridTileBar(
                                        title: Row(
                                          children: [
                                            const Spacer(),
                                            CircleAvatar(
                                                backgroundColor: AppColors
                                                    .blackColor
                                                    .withOpacity(.5),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    controller.deleteItem(
                                                        productId: snapshot
                                                            .data!
                                                            .docs[index]
                                                            .id);
                                                  },
                                                  child: Icon(IconlyBold.delete,
                                                      size:  30 ,
                                                      color: Colors.red),
                                                ))
                                          ],
                                        ),
                                      ),
                                      footer: GridTileBar(
                                        backgroundColor: const Color.fromARGB(
                                            81, 20, 28, 100),
                                        title: TextWidget(
                                          text: camilCaseMethod(snapshot
                                              .data!.docs[index]
                                              .get("product_name")),
                                          color: Colors.white,
                                          maxlines: 1,
                                          textSize: getHeight(24),
                                        ),
                                        subtitle: TextWidget(
                                            text:
                                                "${snapshot.data!.docs[index].get("price")} LE",
                                            color: Colors.white,
                                            textSize: getFont(17)),
                                      ),
                                      child: FancyShimmerImage(
                                          imageUrl: snapshot.data!.docs[index]
                                              .get("product_image")),
                                    ),
                                  ),
                                );
                              });
                        }
                      } else if (snapshot.hasError) {
                        return Text(
                          "Something went wrong, Try again later",
                          style: TextStyle(
                              fontSize: getFont(25),
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        );
                      }
                      return const LoadingItem();
                    },
                  );
          })),
    );
  }
}
