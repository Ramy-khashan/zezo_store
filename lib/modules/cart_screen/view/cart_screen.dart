import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/widgets/loading_item.dart';
import '../controller/cart_cubit.dart';
import '../../order_process/view/order_process_screen.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/size_config.dart';
import '../../../core/widgets/empty_screen.dart';
import '../../../core/widgets/text_widget.dart';
import 'widgets/cart_item.dart';
import 'widgets/text_button_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
        create: (context) => CartCubit()..getUserDetails(),
        child: Scaffold(
          appBar: AppBar(
            scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
          elevation: 0,
            centerTitle: true,
            leading: const SizedBox.shrink(),
            title: TextWidget(
              text: 'Cart',
              textSize: getFont(30),
              isBold: true,
            ),
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
              BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  final controller = CartCubit.get(context);

                  return controller.isLoadingAddCart
                      ? const LoadingItem()
                      : controller.cartProducts.isEmpty
                          ? const Center(
                              child: EmptyScreen(
                                imagePath: 'assets/images/cart.png',
                                headText: 'Your cart is empty',
                                text: 'Add something and make me happy :)',
                                textButton: 'Browse Products',
                              ),
                            )
                          : Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(vertical:10,horizontal: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          width: 1.5,
                                          color: Theme.of(context).primaryColor,)),
                                  padding:
                                      const EdgeInsets. all( 5),
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      TextButtonItem(
                                        text: 'Order now',
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 8),
                                        backgroundColor: Colors.green,
                                        textColor: AppColors.whiteColor,
                                        textSize: getFont(20),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    OrderProcessScreen(
                                                        totalPrice:
                                                            controller.totalPrice,
                                                        cartProduct: controller
                                                            .cartProducts),
                                              ));
                                        },
                                      ),
                                      const Spacer(),
                                      TextWidget(
                                        text:
                                            'Total: ${controller.totalPrice.toStringAsFixed(2)} LE',
                                        textSize: getFont(22),
                                        isBold: true,
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: ListView.separated(
                                    padding: EdgeInsets.all(getWidth(8)),
                                    separatorBuilder: (context, index) => SizedBox(
                                      height: getHeight(15),
                                    ),
                                    itemBuilder: (context, index) => CartItem(
                                        cartProduct: controller.cartProducts[index],
                                        index: index),
                                    itemCount: controller.cartProducts.length,
                                  ),
                                ),
                              ],
                            );
                },
              ),
            ],
          ),
        ));
  }
}
