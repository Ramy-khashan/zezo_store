// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        create: (context) => OrderCubit()..getUserDetails(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            automaticallyImplyLeading: false,
            leading: const BackIcon(),
            centerTitle: true,
            title: TextWidget(
              color: AppColors.whiteColor,
              text: 'Your Orders',
              textSize: getFont(26),
              isBold: true,
            ),
          ),
          body: BlocBuilder<OrderCubit, OrderState>(builder: (context, state) {
            final controller = OrderCubit.get(context);
            return controller.isLoadingOrdere
                ? const Scaffold(body: LoadingItem())
                : controller.orders.isEmpty
                    ? const EmptyScreen(
                        imagePath: 'assets/images/cart.png',
                        headText: 'You didn\'t place any order yet',
                        text: 'Order something and make me happy :)',
                        textButton: 'Shop Now',
                      )
                    : ListView.separated(
                        itemBuilder: (context, index) =>   OrderItem(orderData:controller.orders[index]),
                        separatorBuilder: (context, index) => const Divider(
                              thickness: 1,
                              color: AppColors.whiteColor,
                            ),
                        itemCount: controller.orders.length);
          }),
        ));
  }
}
