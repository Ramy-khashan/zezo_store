import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/widgets/loading_item.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/functions/validate.dart';
import '../../../core/utils/size_config.dart';
import '../../../core/widgets/auth_button.dart';
import '../../../core/widgets/text_widget.dart';
import '../../../core/widgets/textfield_item.dart';
import '../controller/special_order_cubit.dart';

class SpecialOrderScreen extends StatelessWidget {
  const SpecialOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => SpecialOrderCubit()..getData(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          leading: const SizedBox.shrink(),
          title: TextWidget(
            text: 'Special Order',
            color: AppColors.whiteColor,
            textSize: getFont(30),
            isBold: true,
          ),
          actions: [
            IconButton(
              onPressed: () {
                AwesomeDialog(
                  dialogBackgroundColor: Colors.grey.shade200,
                  context: context,
                  dialogType: DialogType.info,
                  body: Padding(
                    padding: EdgeInsets.all(getWidth(12)),
                    child: Text(
                        "Write down your order and we will contact you as soon as possible.",
                        style: TextStyle(
                            fontSize: getFont(22),
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500)),
                  ),
                ).show();
              },
              icon: const Icon(
                Icons.help,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: BlocBuilder<SpecialOrderCubit, SpecialOrderState>(
          builder: (context, state) {
            final controller = SpecialOrderCubit.get(context);
            return controller.isLoadingData
                ? const LoadingItem()
                : Form(
                    key: controller.key,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(10),
                      child: Column(children: [
                        TextFieldItem(
                          verticalPadding: getHeight(10),
                          raduis: 10,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.text,
                          validator: (val) => Validate.notEmpty(val!),
                          controller: controller.orderController,
                          prefexIcon: Icons.backpack_rounded,
                          hintText: "Order",
                        ),
                        TextFieldItem(
                          verticalPadding: getHeight(10),
                          raduis: 10,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.text,
                          validator: (val) => Validate.notEmpty(val!),
                          controller: controller.fullNameController,
                          prefexIcon: Icons.backpack_rounded,
                          hintText: "Full Name",
                        ),
                        TextFieldItem(
                          verticalPadding: getHeight(10),
                          raduis: 10,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.emailAddress,
                          validator: (val) => Validate.validateEmail(val!),
                          controller: controller.emailController,
                          prefexIcon: Icons.email,
                          hintText: "Email",
                        ),
                        TextFieldItem(
                          verticalPadding: getHeight(10),
                          raduis: 10,
                          textInputAction: TextInputAction.next,
                          validator: (val) =>
                              Validate.validateEgyptPhoneNumber(val!),
                          controller: controller.phoneController,
                          textInputType: TextInputType.number,
                          prefexIcon: Icons.phone,
                          hintText: "Phone",
                        ),
                        TextFieldItem(
                          verticalPadding: getHeight(10),
                          maxlines: 3,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.text,
                          validator: (val) => Validate.notEmpty(val!),
                          raduis: 10,
                          controller: controller.addressController,
                          prefexIcon: Icons.home,
                          hintText: "Address",
                        ),
                        TextFieldItem(
                          verticalPadding: getHeight(10),
                          raduis: 10,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.text,
                          validator: (val) => Validate.notEmpty(val!),
                          controller: controller.descriptionController,
                          prefexIcon: Icons.description,
                          hintText: "Description",
                          maxlines: 3,
                        ),
                        SizedBox(
                          height: getFont(20),
                        ),
                        AuthButton(
                            onPressed: () {
                              controller.createOrder();
                            },
                            buttonText: 'Order Now!',
                            color: Colors.grey.shade400.withOpacity(.6)),
                      ]),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
