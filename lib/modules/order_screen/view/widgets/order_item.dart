import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import '../../../../core/utils/functions/app_toast.dart';
import '../../../../core/utils/functions/camil_case.dart';
import '../../../../core/widgets/text_widget.dart';
import '../../model/order_model.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/size_config.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({super.key, required this.orderData});
  final OrderModel orderData;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
        child: Card(
          color: AppColors.blackColor,
          child: Padding(
            padding: EdgeInsets.all(getWidth(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TextWidget(
                        text: "Order Id${orderData.name!.split("/").last}",
                        color: Colors.white,
                        isBold: true,
                        textSize: getFont(21)),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          appToast("Coming soon!");
                        },
                        icon: Icon(
                          IconlyLight.infoSquare,
                          size: 28,
                          color: Colors.white,
                        ))
                  ],
                ),
                Container(
                  margin:
                      EdgeInsets.symmetric(vertical: size.longestSide * .02),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: FancyShimmerImage(
                          imageUrl: orderData
                              .fields!
                              .products!
                              .arrayValue!
                              .values![index]
                              .mapValue!
                              .fields!
                              .image!
                              .stringValue!,
                          height: size.longestSide * .1,
                          width: size.shortestSide * .17,
                        ),
                      ),
                      title: Text(
                        orderData.fields!.products!.arrayValue!.values![index]
                            .mapValue!.fields!.title!.stringValue!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: size.shortestSide * .05,
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        "Quantity : ${orderData.fields!.products!.arrayValue!.values![index].mapValue!.fields!.quantity!.stringValue}",
                        style: TextStyle(
                            fontSize: size.shortestSide * .043,
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w500),
                      ),
                      trailing: Text(
                        "${orderData.fields!.products!.arrayValue!.values![index].mapValue!.fields!.price!.stringValue} LE.",
                        style: TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: size.shortestSide * .045,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    itemCount:
                        orderData.fields!.products!.arrayValue!.values!.length,
                    separatorBuilder: (context, index) => SizedBox(
                      height: getHeight(5),
                    ),
                  ),
                ),
                SizedBox(
                  height: getHeight(8),
                ),
                Text.rich(TextSpan(children: [
                  TextSpan(
                      text: "Payment : ",
                      style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: getFont(21),
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: json.decode(orderData.fields!.paymentData!
                                  .stringValue!)["success"] ==
                              "cash"
                          ? "Cash Payment"
                          : json.decode(orderData.fields!.paymentData!
                                      .stringValue!)["success"] ==
                                  "true"
                              ? "Success"
                              : "Faild",
                      style: TextStyle(
                          color: Colors.amber,
                          fontSize: getFont(21),
                          fontWeight: FontWeight.bold))
                ])),
                SizedBox(
                  height: getHeight(8),
                ),
                TextWidget(
                  text:
                      "Payment Type : ${camilCaseMethod(orderData.fields!.payment!.stringValue!)}",
                  color: Colors.white,
                  textSize: getFont(21),
                  isBold: true,
                ),
                SizedBox(
                  height: 10,
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("configration")
                        .doc("sendOrderMsg")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          "Hint :${snapshot.data!.get("msg")}",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.bold),
                        );
                      }
                      return SizedBox();
                    })
              ],
            ),
          ),
        ));
  }
}
