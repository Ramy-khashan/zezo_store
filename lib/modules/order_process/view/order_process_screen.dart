import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/widgets/loading_item.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/auth_button.dart';
import '../../cart_screen/model/cart_model.dart';
import '../../../core/utils/size_config.dart';
import '../../../core/widgets/back_icon.dart';
import '../../../core/widgets/text_widget.dart';
import '../controller/order_process_cubit.dart';

class OrderProcessScreen extends StatelessWidget {
  const OrderProcessScreen(
      {super.key, required this.totalPrice, required this.cartProduct});
  final double totalPrice;
  final List<CartModel> cartProduct;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => OrderProcessCubit()..getFeeliveryFees(),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            automaticallyImplyLeading: false,
            leading: const BackIcon(),
            centerTitle: true,
            title: TextWidget(
              color: AppColors.whiteColor,
              text: 'Process Order',
              textSize: getFont(26),
              isBold: true,
            ),
          ),
          body: BlocBuilder<OrderProcessCubit, OrderProcessState>(
            builder: (context, state) {
              final controller = OrderProcessCubit.get(context);
              return Form(
                key: controller.formKey,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: size.longestSide * .02),
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: FancyShimmerImage(
                                    imageUrl: cartProduct[index]
                                        .fields!
                                        .productImage!
                                        .stringValue!,
                                    height: 60,
                                    width: 80,
                                  ),
                                ),
                                title: Text(
                                  cartProduct[index]
                                      .fields!
                                      .productName!
                                      .stringValue!,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.w500),
                                ),
                                subtitle: Text(
                                  "Quantity : ${cartProduct[index].fields!.quantity!.integerValue!}",
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.w500),
                                ),
                                trailing: Text(
                                  "${cartProduct[index].fields!.price!.stringValue} LE.",
                                  style: TextStyle(
                                      color: AppColors.whiteColor,
                                      fontSize:19,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              itemCount: cartProduct.length,
                              separatorBuilder: (context, index) => SizedBox(
                                height: getHeight(5),
                              ),
                            ),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(
                          //       horizontal: size.shortestSide * .03,
                          //       vertical: size.longestSide * .013),
                          //   child: TextFieldItem(
                          //     maxlines: 4,
                          //     validator: (val) => Validate.notEmpty(val!),
                          //     controller: controller.addressController,
                          //     hintText: "Address",prefexIcon: Icons.home,
                          //     textInputAction: TextInputAction.done,
                          //     textInputType: TextInputType.emailAddress,
                          //   ),
                          // ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: size.longestSide * .03,
                                horizontal: size.shortestSide * .03),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey.shade200,
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                    color: Color.fromARGB(255, 94, 87, 87),
                                  ),
                                ]),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: getHeight(30), horizontal: 5),
                              child: Center(
                                  child: Text(
                                "Payment only cash at the current moment.",
                                style: TextStyle(
                                    fontSize:19,
                                    fontWeight: FontWeight.w600),
                              )),
                            ),
                            // Column(
                            //   children: [
                            // Row(
                            //   children: [
                            //     Radio(
                            //       value: "cash",
                            //       groupValue: controller.radioValue,
                            //       onChanged: (value) {
                            //         controller.changeValue(value);
                            //       },
                            //       activeColor: AppColors.primaryColor,
                            //     ),
                            //     Text(
                            //       "Cash",
                            //       style: TextStyle(
                            //           fontSize: size.shortestSide * .05,
                            //           fontWeight: FontWeight.w500),
                            //     ),
                            //   ],
                            // ),
                            // Divider(
                            //   indent: size.shortestSide * .1,
                            //   endIndent: size.shortestSide * .1,
                            //   color: Colors.black,
                            // ),
                            // Row(
                            //   children: [
                            //     Radio(
                            //         activeColor: AppColors.primaryColor,
                            //         value: "credit",
                            //         groupValue: controller.radioValue,
                            //         onChanged: (value) {
                            //           controller.changeValue(value);
                            //         }),
                            //     Text(
                            //       "Credit Card",
                            //       style: TextStyle(
                            //           fontSize: size.shortestSide * .05,
                            //           fontWeight: FontWeight.w500),
                            //     ),
                            //   ],
                            // ),

                            //   ],
                            // ),
                          ),
                          controller.isLoadingelivery
                              ? const LoadingItem()
                              : Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.shortestSide * .04),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Total Price : $totalPrice LE",
                                        style: TextStyle(
                                            color: AppColors.whiteColor,
                                            fontSize: size.shortestSide * .05,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: size.longestSide * .01,
                                      ),
                                      Text(
                                        "Delivery Price : ${controller.delivery} LE",
                                        style: TextStyle(
                                            color: AppColors.whiteColor,
                                            fontSize: size.shortestSide * .05,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Divider(
                                        height: size.longestSide * .03,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "Total order price : ${totalPrice + controller.delivery} LE",
                                        style: TextStyle(
                                            color: AppColors.whiteColor,
                                            fontSize: size.shortestSide * .05,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                ),
                          SizedBox(
                            height: size.longestSide * .03,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.shortestSide * .04),
                            child: controller.isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : AuthButton(
                                    onPressed: () {
                                      if (controller.formKey.currentState!
                                          .validate()) {
                                        if (controller.radioValue != null) {
                                          List<Map> products = [];

                                          for (var element in cartProduct) {
                                            products.add({
                                              "mapValue": {
                                                "fields": {
                                                  "title": {
                                                    "stringValue": element
                                                        .fields!
                                                        .productName!
                                                        .stringValue
                                                  },
                                                  "price": {
                                                    "stringValue": element
                                                        .fields!
                                                        .price!
                                                        .stringValue
                                                  },
                                                  "image": {
                                                    "stringValue": element
                                                        .fields!
                                                        .productImage!
                                                        .stringValue
                                                  },
                                                  "product_id": {
                                                    "stringValue": element
                                                        .fields!
                                                        .productId!
                                                        .stringValue
                                                  },
                                                  "quantity": {
                                                    "stringValue": element
                                                        .fields!
                                                        .quantity!
                                                        .integerValue
                                                  }
                                                }
                                              }
                                            });
                                          }
                                          controller.payment(
                                              products, totalPrice, context);
                                        }
                                      }
                                    },
                                    color: Colors.grey.shade400.withOpacity(.6),
                                    buttonText: "Order Now"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          )),
    );
  }
}
