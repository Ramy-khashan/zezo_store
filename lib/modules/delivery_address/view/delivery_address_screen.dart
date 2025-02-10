import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_colors.dart';

import '../../../core/widgets/loading_item.dart';
import '../../add_edit_address/view/add_edit_address.dart';
import '../controller/delivery_address_cubit.dart';

class DeliveryAddressScreen extends StatelessWidget {
  const DeliveryAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeliveryAddressCubit()..getDeliveryAddress(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Delivery Address",
            style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Theme.of(context).brightness.index == 1
                    ? AppColors.blackColor
                    : AppColors.whiteColor),
          ),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AddEditAddressScreen(isAddAddress: true),
                      )).then((value) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DeliveryAddressScreen()));
                  });
                },
                child: Text(
                  "Add Address",
                  style: TextStyle(
                    // fontFamily: MyStrings.fontFamily,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ))
          ],
        ),
        body: BlocBuilder<DeliveryAddressCubit, DeliveryAddressState>(
          builder: (context, state) {
            final controller = DeliveryAddressCubit.get(context);
            return controller.isLoading
                ? LoadingItem()
                : controller.deliveryAddress.isEmpty
                    ? Center(
                        child: Text("No delivery addresses exist",
                            style: TextStyle(
                                // fontFamily: MyStrings.fontFamily,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      )
                    : ListView.builder(
                        itemCount: controller.deliveryAddress.length,
                        itemBuilder: (context, index) => Card(
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
                                  ),
                                  Text(
                                    "City : ${controller.deliveryAddress[index].city ?? "Not Exists"}",
                                  ),
                                  Text(
                                    "Address : ${controller.deliveryAddress[index].fullAddress}",
                                  ),
                                  Text(
                                    "Land Mark : ${controller.deliveryAddress[index].landmark}",
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional.centerEnd,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        InkWell(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddEditAddressScreen(
                                                          deliveryAddressModel:
                                                              controller
                                                                      .deliveryAddress[
                                                                  index],
                                                          isAddAddress: false),
                                                )).then((value) {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DeliveryAddressScreen()));
                                            });
                                          },
                                          child: Card(
                                            // color: AppColors.greenColor,
                                            elevation: 5,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 8),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.edit,
                                                    size: 17,
                                                  ),
                                                  Text(
                                                    "  Edit",
                                                    style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
          },
        ),
      ),
    );
  }
}
