// import 'dart:convert';

// import 'package:equatable/equatable.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import '../../../core/api/dio_consumer.dart';
// import '../../../core/utils/functions/locator_service.dart';

// import '../../../config/app_controller/appcontrorller_cubit.dart';
// import '../../../core/api/end_points.dart';
// import '../../../core/constants/firestore_keys.dart';
// import '../../../core/constants/storage_keys.dart';
// import '../../bottom_navigation_screen/view/bottom_navigation_screen.dart';

// part 'payment_event.dart';
// part 'payment_state.dart';

// class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
//   static PaymentBloc get(context) => BlocProvider.of(context);
//   // String? userId;
//   // getUSerDetails() async {
//   //   FlutterSecureStorage storage = const FlutterSecureStorage();
//   //   userId = await storage.read(key: StorageKeys.userId);
//   // }

//   // getPaymentData(List paymentList, context, Map map) async {
//   //   paymentList.removeAt(0);
//   //   if (kDebugMode) {}
//   //   Map paymentResultMap = {};
//   //   for (String element in paymentList) {
//   //     paymentResultMap.addAll(
//   //         {element.split("=")[0].toString(): element.split("=")[1].toString()});
//   //   }
//   //   map.addAll({
//   //     "payment_data": {
//   //       "stringValue": json.encode(paymentResultMap),
//   //     },
//   //     "user_id": {"stringValue": userId}
//   //   });
//   //   Map<String, dynamic> finalMap = {'fields': map};

//   //   debugPrint(finalMap.toString());
//   //   if (paymentResultMap["success"] == "true") {
//   //     await serviceLocator
//   //         .get<DioConsumer>()
//   //         .post("${EndPoints.firestoreBaseUrl}/order/", body: finalMap)
//   //         .whenComplete(() async {
//   //       await serviceLocator
//   //           .get<DioConsumer>()
//   //           .get(
//   //               "${EndPoints.firestoreBaseUrl}/${FirestoreKeys.cart}/$userId/${FirestoreKeys.cartProducts}")
//   //           .then((value) {
//   //         for (var element in List.from(value["documents"])) {
//   //           serviceLocator.get<DioConsumer>().delete(
//   //               "${EndPoints.firestoreBaseUrl}/${FirestoreKeys.cart}/$userId/${FirestoreKeys.cartProducts}/${element["name"].split("/").last}");
//   //         }
//   //       });
//   //       AppcontrorllerCubit.get(context).getCartLenth( );
//   //     });
//   //     Fluttertoast.showToast(
//   //         msg: paymentResultMap["success"] == "true"
//   //             ? "Order Created Successfully"
//   //             : "Order Failed, Please try again!");
//   //     Navigator.pushAndRemoveUntil(
//   //         context,
//   //         MaterialPageRoute(
//   //           builder: (context) => const BottomNavigationScreen(),
//   //         ),
//   //         (route) => false);
//   //   }
//   // }

//   // PaymentBloc() : super(PaymentInitial()) {
//   //   on<PaymentEvent>((event, emit) {
//   //     if (event is PaymentResponseEvent) {
//   //       getPaymentData(event.paymentList, event.context, event.map);
//   //     }
//   //   });
//   // }
// }
