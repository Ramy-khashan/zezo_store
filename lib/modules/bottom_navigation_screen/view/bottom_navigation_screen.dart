import 'package:cloud_firestore/cloud_firestore.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import '../../../core/widgets/loading_item.dart';

 import '../../../core/utils/size_config.dart';
import '../controller/bottom_navigation_bar_cubit.dart';

class BottomNavigationScreen extends StatelessWidget {
  const BottomNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BottomNavigationBarCubit()..getDetails(),
      child: BlocBuilder<BottomNavigationBarCubit, BottomNavigationBarState>(
        builder: (context, state) {
          final controller = BottomNavigationBarCubit.get(context);
          return controller.isLoading
              ? const LoadingItem()
              : Scaffold(
                  body: controller.pages[controller.currentIndex],
                  bottomNavigationBar: BottomNavigationBar(
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      currentIndex: controller.currentIndex,
                      onTap: (value) => controller.selectedPage(value, context),
                      type: BottomNavigationBarType.shifting,
                      selectedItemColor: Colors.lightBlue.shade200,
                      unselectedItemColor: Colors.grey.shade300,
                      items: [
                        BottomNavigationBarItem(
                          icon: Icon(controller.currentIndex == 0
                              ? IconlyBold.home
                              : IconlyLight.home),
                          label: 'Home',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(controller.currentIndex == 1
                              ? IconlyBold.category
                              : IconlyLight.category),
                          label: 'Category',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(controller.currentIndex == 3
                              ? IconlyLight.ticketStar
                              : IconlyBold.ticketStar),
                          label: 'Special Order',
                        ),
                        BottomNavigationBarItem(
                          icon: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("cart")
                                  .doc(controller.userId)
                                  .collection("cart_products")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if(snapshot.hasData){
                                return Stack(
                                  children: [
                                    Icon(controller.currentIndex == 2
                                        ? IconlyLight.buy
                                        : IconlyBold.buy),
                                    Visibility(
                                      visible: snapshot.data!.docs.isEmpty
                                          ? controller.cartLength == 0
                                              ? false
                                              : true
                                          : true,
                                      child: FractionalTranslation(
                                          translation: const Offset(.6, -.4),
                                          child: Container(
                                            padding: const EdgeInsets.all(2),
                                            width: getWidth(20),
                                            height: getHeight(20),
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.red,
                                            ),
                                            alignment: Alignment.center,
                                            child: FittedBox(
                                              child: Text(
                                                snapshot.data!.docs.isEmpty
                                                    ? controller.cartLength
                                                        .toString()
                                                    : snapshot.data!.docs.length
                                                        .toString(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          )),
                                    )
                                  ],
                                );}
                                return const Icon(IconlyLight.buy);
                              }),
                          label: 'Cart',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(controller.currentIndex == 4
                              ? IconlyBold.user2
                              : IconlyLight.user2),
                          label: 'User',
                        ),
                      ]),
                );
        },
      ),
    );
  }
}
