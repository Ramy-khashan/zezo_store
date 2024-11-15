import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/firestore_keys.dart';
import '../../../core/utils/functions/camil_case.dart';
import '../../../core/utils/functions/app_toast.dart';
import '../../../core/widgets/loading_item.dart';
import '../../../config/app_controller/appcontrorller_cubit.dart'; 
import '../../../core/constants/route_key.dart';
import '../../../core/utils/functions/add_to_favorite.dart';
import '../../../core/widgets/on_sale_item.dart';
import '../../../core/widgets/text_widget.dart';
import '../../../core/utils/size_config.dart';
import '../controller/home_page_cubit.dart';
import 'widgets/product_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return BlocProvider.value(
      value: AppcontrorllerCubit(),
      child: BlocProvider(
        create: (context) => HomePageCubit()..getUSerDetails(),
        child: BlocConsumer<HomePageCubit, HomePageState>(
          listener: (context, state) {
            if (state is FailedGetAllProductState) {
              appToast(state.error);
            }
            if (state is FailedGetOnSaleProductState) {
              appToast(state.error);
            }
            if (state is FailedGetAdsState) {
              appToast(state.error);
            }
          },
          builder: (context, state) {
            final controller = HomePageCubit.get(context);

            return Scaffold(
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
                    SafeArea(
              child: SingleChildScrollView(
                    child: Column(
                      children: [
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection(FirestoreKeys.ads)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return snapshot.data!.docs.isEmpty
                                    ? const SizedBox()
                                    : SizedBox(
                                        height: getHeight(320),
                                        child: Swiper(
                                          itemBuilder:
                                              (BuildContext context, int index) {
                                            return FancyShimmerImage(
                                              imageUrl: snapshot.data!.docs[index]
                                                  .get("ads_image")!,
                                              boxFit: BoxFit.fill,
                                            );
                                          },
                                          autoplay: snapshot.data!.docs.length == 1
                                              ? false
                                              : true,
                                          itemCount: snapshot.data!.docs.length,
                                          pagination:   SwiperPagination(
                                              alignment: Alignment.bottomCenter,
                                              builder: DotSwiperPaginationBuilder(
                                                  color: Colors.white,
                                                  activeColor:
                                                   Theme.of(context).primaryColor,)),
                                          // control: const SwiperControl(color: Colors.black),
                                        ),
                                      );
                              }
                              if (snapshot.hasError) {}
                              return SizedBox(
                                  height: getHeight(320),
                                  child: const LoadingItem());
                            }),
                        SizedBox(
                          height: getHeight(10),
                        ),
                        SizedBox(
                          height: getHeight(10),
                        ),
                        Row(
                          children: [
                            RotatedBox(
                              quarterTurns: -1,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TextWidget(
                                    text: 'On sale'.toUpperCase(),
                                    color: Colors.deepOrange,
                                    textSize: getFont(32),
                                    isBold: true,
                                  ),
                                  SizedBox(
                                    width: getWidth(5),
                                  ),
                                  const Icon(
                                    IconlyLight.discount,
                                    color: Colors.deepOrange,
                                  ),
                                ],
                              ),
                            ),
                            StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("product")
                                    .where("is_on_sale", isEqualTo: true)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Flexible(
                                      child: SizedBox(
                                        height: getHeight(200),
                                        child: snapshot.data!.docs.isEmpty
                                            ? Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    camilCaseMethod(
                                                      "no product is on sale at this moment",
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle( 
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: getFont(25)),
                                                  ),
                                                ),
                                              )
                                            : ListView.separated(
                                                padding: const EdgeInsets.all(8),
                                                itemBuilder: (context, index) =>
                                                    OnSaleItem(
                                                  onTapCart: () async {
                                                    controller.addToCart(
                                                        snapshot.data!.docs[index]);
                                                  },
                                                  product:
                                                      snapshot.data!.docs[index],
                                                  onTapFavorite: () async {
                                                    await addTofavorite(
                                                      userId: controller.userId!,
                                                      productId: snapshot
                                                          .data!.docs[index].id,
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
                                                ),
                                                separatorBuilder:
                                                    (context, index) => SizedBox(
                                                  width: getWidth(8),
                                                ),
                                                itemCount:
                                                    snapshot.data!.docs.length,
                                                scrollDirection: Axis.horizontal,
                                              ),
                                      ),
                                    );
                                  } else if (snapshot.hasData) {}
                                  return const Flexible(child: LoadingItem());
                                }),
                          ],
                        ),
                        SizedBox(
                          height: getHeight(10),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getWidth(10), vertical: getHeight(3)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextWidget(
                                text: 'Our Products',
                                textSize: getFont(26),
                                isBold: true,
                              ),
                              GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                    context, RouteKeys.allProductScreen),
                                child: TextWidget(
                                  text: 'Browse All',
                                  color: Colors.cyan,
                                  textSize: getFont(22),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: getHeight(4),
                        ),
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("product")
                                .where("important", isEqualTo: true)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text(
                                    camilCaseMethod(
                                        "Something went wrong try again!"),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: getFont(25),
                                        fontWeight: FontWeight.bold, ),
                                  ),
                                );
                              } else if (snapshot.hasData) {
                                return GridView.count(
                                  padding: EdgeInsets.all(getWidth(10)),
                                  crossAxisCount: 2,
                                  childAspectRatio: 7 / 9,
                                  mainAxisSpacing: 13,
                                  // cacheExtent: 200,
                                  crossAxisSpacing: 10,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  children: List.generate(
                                      snapshot.data!.docs.length > 8
                                          ? 8
                                          : snapshot.data!.docs.length,
                                      (index) => ProductViewItem(
                                            onTapCart: () async {
                                              await controller.addToCart(
                                                  snapshot.data!.docs[index]);
                                            },
                                            product: snapshot.data!.docs[index],
                                            onTapFavorite: () async {
                                              await addTofavorite(
                                                userId: controller.userId,
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
                                          )),
                                );
                              }
                              return const LoadingItem();
                            })
                      ],
                    ),
              ),
            ),
                  ],
                ));
          },
        ),
      ),
    );
  }
}
