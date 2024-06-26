import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/functions/camil_case.dart';
import '../../../core/utils/size_config.dart';
import '../../../core/widgets/back_icon.dart';
import '../../../core/widgets/get_order_process_shape.dart';
import '../../../core/widgets/loading_item.dart';
import '../../../core/widgets/text_widget.dart';
import '../controller/special_order_request_cubit.dart';

class SpecialOrderRequests extends StatelessWidget {
  const SpecialOrderRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SpecialOrderRequestCubit()..getUser(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          leading: const BackIcon(),
          centerTitle: true,
          title: const TextWidget(
            text: 'Special Order Requests',
            textSize:  22,
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
            BlocBuilder<SpecialOrderRequestCubit, SpecialOrderRequestState>(
              builder: (context, state) {
                final controller = SpecialOrderRequestCubit.get(context);
                return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("specialOrder")
                        .where("user_id", isEqualTo: controller.userId)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return snapshot.data!.docs.isEmpty
                            ? Center(
                                child: Text(
                                  camilCaseMethod("There is no orders for you"),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: getFont(25),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            : ListView.separated(
                                itemBuilder: (context, index) => Card( 
                                      child: SingleChildScrollView(
                                        padding: EdgeInsets.all(getWidth(10)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SelectableText(
                                              "Order Id : ${snapshot.data!.docs[index].id}",
                                              style: TextStyle(
                                                  fontSize: getFont(23),
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              height: getHeight(10),
                                            ),
                                            Center(
                                              child: TextWidget(
                                                  text: snapshot.data!.docs[index]
                                                      .get("special_order"),
                                                  isBold: true,
                                                  textSize: getFont(25)),
                                            ),
                                            SizedBox(
                                              height: getHeight(10),
                                            ),
                                            TextWidget(
                                                isBold: true,
                                                text: "Order Description : ",
                                                textSize: getFont(22)),
                                            TextWidget(
                                                text: snapshot.data!.docs[index]
                                                    .get("description"),
                                                textSize: getFont(22)),
                                            SizedBox(
                                              height: getHeight(7),
                                            ),
                                            TextWidget(
                                                text:
                                                    "Order by : ${snapshot.data!.docs[index].get("full_name")}",
                                                textSize: getFont(22)),
                                            SizedBox(
                                              height: getHeight(7),
                                            ),
                                            TextWidget(
                                                text:
                                                    "Email : ${snapshot.data!.docs[index].get("email")}",
                                                textSize: getFont(22)),
                                            SizedBox(
                                              height: getHeight(7),
                                            ),
                                            TextWidget(
                                                text:
                                                    "Phone : ${snapshot.data!.docs[index].get("phone")}",
                                                textSize: getFont(22)),
                                            SizedBox(
                                              height: getHeight(7),
                                            ),
                                            Row(
                                              children: [
                                                TextWidget(
                                                    text:
                                                        "Order Status : ${camilCaseMethod(snapshot.data!.docs[index].get("status"))}",
                                                    textSize: getFont(22)),
                                                const Spacer(),
                                                GetSpecialOrderShape(
                                                    status: snapshot
                                                        .data!.docs[index]
                                                        .get("status"))
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                separatorBuilder: (context, index) => SizedBox(
                                      height: getHeight(7),
                                    ),
                                itemCount: snapshot.data!.docs.length);
                      } else if (snapshot.hasError) {
                        return const Center(
                            child: Text("Something went wrong, Try again later"));
                      }

                      return const LoadingItem();
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
