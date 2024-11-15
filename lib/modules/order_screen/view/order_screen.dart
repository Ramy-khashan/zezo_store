// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/utils/enums.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/size_config.dart';
import '../../../core/widgets/back_icon.dart';
import '../../../core/widgets/empty_screen.dart';
import '../../../core/widgets/loading_item.dart';
import '../../../core/widgets/text_widget.dart';
import '../controller/order_cubit.dart';
import 'widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => OrderCubit()..getOrders(),
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              automaticallyImplyLeading: false,
              leading: const BackIcon(),
              centerTitle: true,
              title: TextWidget(
                text: 'Your Orders',
                textSize: getFont(26),
                isBold: true,
              ),
            ),
            body:
                BlocBuilder<OrderCubit, OrderState>(builder: (context, state) {
              return RefreshIndicator.adaptive(
                onRefresh: ()async{
                await  BlocProvider.of<OrderCubit>(context).getOrders();
                },
                child: Stack(
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
                    if (state.status == OperationStatus.loading) LoadingItem(),
                    if (state.status == OperationStatus.failed)
                      const Center(
                        child: Text(
                          "Something went wrong, Try again later.",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    if (state.status == OperationStatus.success)
                      state.orders.isEmpty
                          ? const EmptyScreen(
                              imagePath: 'assets/images/cart.png',
                              headText: 'You didn\'t place any order yet',
                              text: '',
                              textButton: 'Shop Now',
                            )
                          : ListView.separated(
                              itemBuilder: (context, index) =>
                                  OrderItem(orderData: state.orders[index]),
                              separatorBuilder: (context, index) => const Divider(
                                    thickness: 1,
                                  ),
                              itemCount: state.orders.length),
                  ],
                ),
              );
            })));
  }
}
