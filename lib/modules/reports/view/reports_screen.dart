import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/auth_button.dart'; 
import '../../../core/utils/size_config.dart';
import '../../../core/widgets/back_icon.dart';
import '../../../core/widgets/loading_item.dart';
import '../../../core/widgets/text_widget.dart';
import '../../../core/widgets/textfield_item.dart';
import '../controller/report_cubit.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return BlocProvider(
      create: (context) => ReportCubit()..getIntialVal(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: const BackIcon(),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          title: TextWidget(
            text: 'Reports',
            textSize: getFont(24),
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
            Padding(
              padding: EdgeInsets.all(getHeight(8)),
              child: BlocConsumer<ReportCubit, ReportState>(
                listener: (context, state) {
                  if (state is FaildUploadReporState) {
                    Fluttertoast.showToast(
                        msg: "Something went wrong witn ${state.error}",
                        gravity: ToastGravity.SNACKBAR,
                        backgroundColor: Theme.of(context).primaryColor,);
                  } else if (state is SuccessUploadReporState) {
                    Fluttertoast.showToast(
                        msg: "Send Your Report, done!",
                        backgroundColor: Theme.of(context).primaryColor,);
                  }
                },
                builder: (context, state) {
                  final controller = ReportCubit.get(context);
                  return controller.isLoadingData
                      ? const LoadingItem()
                      : SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TextFieldItem(
                                textInputType: TextInputType.emailAddress,
                                maxlines: 12,
                                hintText: "Write Report Issue here",
                                controller: controller.reportController,
                                textInputAction: TextInputAction.next,
                              ),
                              SizedBox(
                                height: getHeight(20),
                              ),
                              TextFieldItem(
                                textInputAction: TextInputAction.next,
                                textInputType: TextInputType.emailAddress,
                                hintText: "Your Email",
                                prefexIcon: Icons.email_rounded,
                                controller: controller.emailController,
                              ),
                              SizedBox(
                                height: getHeight(20),
                              ),
                              TextFieldItem(
                                textInputAction: TextInputAction.done,
                                textInputType: TextInputType.phone,
                                hintText: "Phone Number",
                                prefexIcon: Icons.phone,
                                controller: controller.phoneController,
                              ),
                              SizedBox(
                                height: getHeight(160),
                              ),
                              controller.isLoading
                                  ? const LoadingItem()
                                  : AppButton(
                                      buttonText: "Report",
                                      onPressed: () async {
                                        if (controller.reportController.value.text
                                            .trim()
                                            .isNotEmpty) {
                                          if (controller.emailController.value.text
                                                  .trim()
                                                  .isNotEmpty ||
                                              controller.phoneController.value.text
                                                  .trim()
                                                  .isNotEmpty) {
                                            await controller.uploadReport();
                                          }
                                        } else {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Please fill Fields with your issue ",
                                              backgroundColor:
                                                  Colors.amber.shade700);
                                        }
                                      },
                                      color: Colors.grey,
                                    ),
                              SizedBox(
                                height: getHeight(10),
                              )
                            ],
                          ),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
