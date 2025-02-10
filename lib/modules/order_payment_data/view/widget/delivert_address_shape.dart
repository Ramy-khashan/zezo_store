import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/modules/order_payment_data/controller/order_payment_cubit.dart';
 
  
import '../../../../core/constants/app_colors.dart';
  

class DeliveryAddressShape extends StatelessWidget {
  const DeliveryAddressShape(
      {super.key, required this.index,  });
  final int index;
 
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderPaymentCubit, OrderPaymentState>(
      builder: (context, state) {
        final controller = OrderPaymentCubit.get(context);
        return InkWell(
            onTap: () {},
            child: Row(
              children: [
                Radio(
                    value: index,
                    groupValue: controller.selectedDeliveryAddress,
                    onChanged: (val) {
                      controller.onSelectDeliveryAddress(val);
                    }),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DefaultTextStyle(
                        style: TextStyle(
                            color: Theme.of(context).brightness.index == 1
                                ? AppColors.blackColor
                                : AppColors.whiteColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name : ${controller.deliveryAddress[index].fullName}",
                            ),
                            Text(
                              "Phone : ${controller.deliveryAddress[index].phone1}",
                            ),
                            Text(
                              "Phone2 : ${controller.deliveryAddress[index].phone2!.isEmpty ? "Not Exists" : controller.deliveryAddress[index].phone2}",
                            ),
                               Text(
                                    "Street : ${controller.deliveryAddress[index].street ?? "Not Exists"}",
                                  ),
                                  Text(
                                    "Building : ${controller.deliveryAddress[index].building ?? "Not Exists"}",
                                  ), Text(
                                    "City : ${controller.deliveryAddress[index].city ?? "Not Exists"}",
                                  ),
                            Text(
                              "Address : ${controller.deliveryAddress[index].fullAddress}",
                            ),
                            Text(
                              "Land Mark : ${controller.deliveryAddress[index].landmark}",
                            ),
                           ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ));
      },
    );
  }
}
