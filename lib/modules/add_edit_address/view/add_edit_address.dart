import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/functions/validate.dart';
import '../../../core/widgets/loading_item.dart';
import '../../../core/widgets/textfield_item.dart';
import '../controller/add_edit_address_cubit.dart';
import '../model/delivery_address_model.dart';

class AddEditAddressScreen extends StatelessWidget {
  const AddEditAddressScreen(
      {super.key, required this.isAddAddress, this.deliveryAddressModel});
  final bool isAddAddress;
  final DeliveryAddressModel? deliveryAddressModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEditAddressCubit(
          isAddAddress: isAddAddress,
          deliveryAddressModel: deliveryAddressModel),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            isAddAddress ? "Add" : "Edit",
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 23,
                color: Theme.of(context).brightness.index == 1
                    ? AppColors.blackColor
                    : AppColors.whiteColor),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<AddEditAddressCubit, AddEditAddressState>(
          builder: (context, state) {
            final controller = AddEditAddressCubit.get(context);
            return Form(
              key: controller.formKey,
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFieldItem(
                              controller: controller.fullName,
                              validator: (val) => Validate.notEmpty(val!),
                              hintText: "Full Name",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFieldItem(
                                controller: controller.phone1,
                                validator: (val) =>
                                    Validate.validateEgyptPhoneNumber(val!),
                                textInputType: TextInputType.phone,
                                hintText: "Phone Number"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFieldItem(
                                controller: controller.phone2,
                                validator: (val) => val.toString().isEmpty
                                    ? null
                                    : Validate.validateEgyptPhoneNumber(val!),
                                hintText: "Phone Number 2"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFieldItem(
                                controller: controller.streetName,
                                validator: (val) => Validate.notEmpty(val!),
                                hintText: "Street Name"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFieldItem(
                                controller: controller.building,
                                validator: (val) => Validate.notEmpty(val!),
                                hintText: "Building"),
                          ), Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFieldItem(
                                controller: controller.city,
                                validator: (val) => Validate.notEmpty(val!),
                                hintText: "City"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFieldItem(
                                controller: controller.fullAddress,
                                validator: (val) => Validate.notEmpty(val!),
                                hintText: "Full Address"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFieldItem(
                              controller: controller.landMark,
                              validator: (val) => Validate.notEmpty(val!),
                              hintText: "Land Mark",
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 20),
                        child: controller.isLoading
                            ? LoadingItem()
                            : ElevatedButton(
                                onPressed: () {
                                  if (controller.formKey.currentState!
                                      .validate()) {
                                    isAddAddress
                                        ? controller.addToDeliveryAddress()
                                        : controller.editDeliveryAddress(
                                            deliveryAddressModel:
                                                deliveryAddressModel!);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                ),
                                child: Text(
                                  isAddAddress ? "Add" : "Edit",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15),
                                )))
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
