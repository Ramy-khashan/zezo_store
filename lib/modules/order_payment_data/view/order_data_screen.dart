import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/widgets/loading_item.dart';
import '../../../core/constants/app_colors.dart';
 import '../../../core/utils/size_config.dart';
import '../../../core/widgets/auth_button.dart';
import '../../../core/widgets/back_icon.dart';
import '../../../core/widgets/text_widget.dart';
import '../../add_edit_address/view/add_edit_address.dart';
import '../../delivery_address/view/delivery_address_screen.dart';
import '../controller/order_payment_cubit.dart';
import 'widget/delivert_address_shape.dart';
 
class OrderPaymentDataScreen extends StatelessWidget {
  final Map map;
  const OrderPaymentDataScreen({super.key, required this.map});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderPaymentCubit()
        ..getIntialVal()..getDeliveryAddress(),
        // ..initializePayment(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: const BackIcon(),
          centerTitle: true,
          title: TextWidget(
            text: 'Process Order',
            textSize: getFont(26),
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
            BlocBuilder<OrderPaymentCubit, OrderPaymentState>(
              builder: (context, state) {
                final controller = OrderPaymentCubit.get(context);
                return controller.isLoadingData
                    ? const LoadingItem()
                    : SafeArea(
                        child: Form(
                          key: controller.formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                controller.isLoading
                          ? LoadingItem()
                          : controller.deliveryAddress.isEmpty
                              ? Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("No delivery addresses exist",
                                          style: TextStyle(
                                              // fontFamily: MyStrings.fontFamily,
                                              fontSize: 27,
                                              fontWeight: FontWeight.bold)),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 20),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 20)),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddEditAddressScreen(
                                                          isAddAddress: true),
                                                )).then((value) {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DeliveryAddressScreen()));
                                            });
                                          },
                                          child: Center(
                                            child: Text(
                                              "Add Delivery Address",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 18),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Row(
                                        children: [
                                          Text("Delivery Address",
                                              style: TextStyle(
                                                    fontSize: 27,
                                                  fontWeight: FontWeight.bold)),
                                          Spacer(),
                                          IconButton(
                                              onPressed: () {
                                                controller
                                                    .toggleDeliveryAddress();
                                              },
                                              icon: Icon(controller
                                                      .isToggledDeliveryAddress
                                                  ? Icons.arrow_drop_up_rounded
                                                  : Icons
                                                      .arrow_drop_down_rounded))
                                        ],
                                      ),
                                    ),
                                    AnimatedContainer(
                                      duration: Duration(milliseconds: 500),
                                      height: controller
                                              .isToggledDeliveryAddress
                                          ? 0
                                          : controller.deliveryAddress.length *
                                              165,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount:
                                              controller.deliveryAddress.length,
                                          itemBuilder: (context, index) =>
                                              DeliveryAddressShape(
                                               
                                                  index: index)),
                                    ),
                                  ],
                                ),
                    
                                
                                controller.isLoadingCreateOrder
                                    ? const LoadingItem()
                                    : AppButton(
                                        onPressed: () {
                                          if (controller.formKey.currentState!
                                              .validate()) {
                                            controller.createOrder(
                                                context: context, map: map);
                                          }
                                        },
                                        color: Colors.grey,
                                        buttonText: "Go To Pay"),
                              ],
                            ),
                          ),
                        ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
