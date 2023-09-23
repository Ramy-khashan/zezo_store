import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/repository/order_data_repo/order_data_repo_impl.dart';
import '../../../core/utils/functions/locator_service.dart';
import '../../../core/utils/functions/validate.dart';
import '../../../core/utils/size_config.dart';
import '../../../core/widgets/auth_button.dart';
import '../../../core/widgets/back_icon.dart';
import '../../../core/widgets/text_widget.dart';
import '../bloc/order_data_bloc.dart';
import 'widget/order_payment_textfield.dart';

class OrderPaymentDataScreen extends StatelessWidget {
  final Map map;
  const OrderPaymentDataScreen({super.key, required this.map});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderPaymentDataBloc(
          orderDataRepoImpl: serviceLocator.get<OrderDataRepoImpl>()),
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
        body: BlocBuilder<OrderPaymentDataBloc, OrderPaymentDataState>(
          builder: (context, state) {
            final controller = OrderPaymentDataBloc.get(context);
            return SafeArea(
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
                            Row(
                              children: [
                                Expanded(
                                  child: OrderPaymentTextfieldItem(
                                      controller:
                                          controller.fristNameController,
                                      hint: "Frist Name",
                                      validate: (val) => Validate.notEmpty(val),
                                      textInputType:
                                          TextInputType.emailAddress),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: OrderPaymentTextfieldItem(
                                      controller: controller.lastNameController,
                                      hint: "Last Name",
                                      validate: (val) => Validate.notEmpty(val),
                                      textInputType:
                                          TextInputType.emailAddress),
                                ),
                              ],
                            ),
                            OrderPaymentTextfieldItem(
                                controller: controller.emailController,
                                hint: "E-Mail",
                                validate: (val) => Validate.validateEmail(val),
                                textInputType: TextInputType.emailAddress),
                            OrderPaymentTextfieldItem(
                                controller: controller.phoneController,
                                hint: "Phone",
                                validate: (val) =>
                                    Validate.validateEgyptPhoneNumber(val),
                                textInputType: TextInputType.phone),
                            OrderPaymentTextfieldItem(
                                controller: controller.cityController,
                                hint: "City",
                                validate: (val) => Validate.notEmpty(val),
                                textInputType: TextInputType.text),
                            OrderPaymentTextfieldItem(
                                controller: controller.apartmentController,
                                hint: "Apartment",
                                validate: (val) => Validate.notEmpty(val),
                                textInputType: TextInputType.text),
                            OrderPaymentTextfieldItem(
                                controller: controller.floorController,
                                hint: "Floor",
                                validate: (val) => Validate.notEmpty(val),
                                textInputType: TextInputType.number),
                            OrderPaymentTextfieldItem(
                                validate: (val) => Validate.notEmpty(val),
                                controller: controller.buildingtController,
                                hint: "Building",
                                textInputType: TextInputType.text),
                          ]),
                        ),
                      ),
                      AuthButton(
                          onPressed: () {
                            if (controller.formKey.currentState!.validate()) {
                              map["payment"]["stringValue"] == "cash"
                                  ? controller.add(
                                      PayCashEvent(context: context, map: map))
                                  : controller.add(GoToPaymentEvent(
                                      context: context, map: map));
                            }
                          },
                          color: Colors.grey.shade400.withOpacity(.6),
                          buttonText: "Go To Pay"),
                    ],
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
