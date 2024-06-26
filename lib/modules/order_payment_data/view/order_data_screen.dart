import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/widgets/loading_item.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/functions/validate.dart';
import '../../../core/utils/size_config.dart';
import '../../../core/widgets/auth_button.dart';
import '../../../core/widgets/back_icon.dart';
import '../../../core/widgets/text_widget.dart';
import '../controller/order_payment_cubit.dart';
import 'widget/order_payment_textfield.dart';

class OrderPaymentDataScreen extends StatelessWidget {
  final Map map;
  const OrderPaymentDataScreen({super.key, required this.map});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderPaymentCubit()
        ..getIntialVal()
        ..initializePayment(),
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
        body:Stack(
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
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      OrderPaymentTextfieldItem(
                                          controller: controller.fullNameController,
                                          hint: "Full Name",
                                          validate: (val) => Validate.notEmpty(val),
                                          textInputType:
                                              TextInputType.emailAddress),
                                      OrderPaymentTextfieldItem(
                                          controller: controller.emailController,
                                          hint: "E-Mail",
                                          validate: (val) =>
                                              Validate.validateEmail(val),
                                          textInputType:
                                              TextInputType.emailAddress),
                                      OrderPaymentTextfieldItem(
                                          controller: controller.phoneController,
                                          hint: "Phone",
                                          validate: (val) =>
                                              Validate.validateEgyptPhoneNumber(
                                                  val),
                                          textInputType: TextInputType.phone),
                                      OrderPaymentTextfieldItem(
                                          controller: controller.cityController,
                                          hint: "City",
                                          validate: (val) => Validate.notEmpty(val),
                                          textInputType: TextInputType.text),
                                      OrderPaymentTextfieldItem(
                                          controller: controller.streatController,
                                          hint: "Streat",
                                          validate: (val) => Validate.notEmpty(val),
                                          textInputType: TextInputType.number),
                                      OrderPaymentTextfieldItem(
                                          validate: (val) => Validate.notEmpty(val),
                                          controller:
                                              controller.buildingtController,
                                          hint: "Building",
                                          textInputType: TextInputType.text),
                                      OrderPaymentTextfieldItem(
                                          validate: (val) => Validate.notEmpty(val),
                                          lines: 3,
                                          controller: controller.addressController,
                                          hint: "Full Address",
                                          textInputType: TextInputType.text),
                                    ]),
                                  ),
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
