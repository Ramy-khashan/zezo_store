// ignore_for_file: use_build_context_synchronously, invalid_use_of_visible_for_testing_member

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'dart:math';
import '../../../config/app_controller/appcontrorller_cubit.dart';
import '../../../core/api/dio_consumer.dart';
import '../../../core/api/end_points.dart';
import '../../../core/constants/firestore_keys.dart';
import '../../../core/constants/storage_keys.dart';
import '../../../core/repository/order_data_repo/order_data_repo_impl.dart';
import '../../../core/utils/functions/app_toast.dart';
import '../../../core/utils/functions/camil_case.dart';
import '../../../core/utils/functions/locator_service.dart';
import '../../bottom_navigation_screen/view/bottom_navigation_screen.dart';
import '../../payment/view/payment_screen.dart';

part 'order_data_event.dart';
part 'order_data_state.dart';

class OrderPaymentDataBloc
    extends Bloc<OrderPaymentDataEvent, OrderPaymentDataState> {
  final OrderDataRepoImpl orderDataRepoImpl;
  static OrderPaymentDataBloc get(context) => BlocProvider.of(context);
  final formKey = GlobalKey<FormState>();
  final fristNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final priceController = TextEditingController();

  final apartmentController = TextEditingController();
  final floorController = TextEditingController();
  final postalCodeController = TextEditingController(text: "");
  final buildingtController = TextEditingController();
  final cityController = TextEditingController(text: "");
  final stateController = TextEditingController(text: "");

  getPaymentToken(
      {required String authToken,
      required context,
      required Map map,
      required Map paymentMap}) async {
    String randomString = String.fromCharCodes(
        List.generate(3, (_) => Random().nextInt(26) + 65));

    final response = await orderDataRepoImpl.getToken(
      authToken: authToken,
      price: map["totalPrice"]["stringValue"],
      map: paymentMap,
      orderId: randomString,
    );
    response.fold((l) {
      Fluttertoast.showToast(msg: "Faild");
    }, (token) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentScreen(token: token, map: map),
          ));
    });
  }

  OrderPaymentDataBloc({required this.orderDataRepoImpl})
      : super(OrderDataInitial()) {
    on<OrderPaymentDataEvent>((event, emit) async {
      if (event is GoToPaymentEvent) {
        event.map.addAll({
          "apartment": {"stringValue": apartmentController.text.trim()},
          "floor": {"stringValue": floorController.text.trim()},
          "country": {"stringValue": "EGP"},
          "postal_code": {"stringValue": postalCodeController.text},
          "first_name": {"stringValue": fristNameController.text},
          "last_name": {"stringValue": lastNameController.text},
          "email": {"stringValue": emailController.text},
          "phone_number": {"stringValue": "+2${phoneController.text}"},
          "building": {"stringValue": buildingtController.text.trim()},
          "street": {"stringValue": addressController.text},
          "shipping_method": {"stringValue": "PKG"},
          "city": {"stringValue": cityController.text.trim()},
          "state": {"stringValue": stateController.text.trim()}
        });
        Map paymentMap = {
          "apartment": apartmentController.text.trim(),
          "floor": floorController.text.trim(),
          "country": "EGP",
          "postal_code": postalCodeController.text,
          "first_name": fristNameController.text,
          "last_name": lastNameController.text,
          "email": emailController.text,
          "phone_number": "+2${phoneController.text}",
          "building": buildingtController.text.trim(),
          "street": addressController.text,
          "shipping_method": "PKG",
          "city": cityController.text.trim(),
          "state": stateController.text.trim()
        };

        isLoading = true;
        emit(LoadingCreateState());
        final response =
            await orderDataRepoImpl.getAuthToken(apiToken: EndPoints.apiToken);
        response.fold((l) {
          isLoading = false;
          emit(FailedCreateState(
              error: camilCaseMethod("Failed to create your order")));
        }, (authToken) async {
          isLoading = false;
          emit(SucessCreateState());
          BlocProvider.of<OrderPaymentDataBloc>(event.context).add(
              GetPaymentOrderIdEvent(
                  paymentMap: paymentMap,
                  authToken: authToken,
                  context: event.context,
                  map: event.map));
        });
      }
      if (event is GetPaymentOrderIdEvent) {
        getPaymentToken(
            authToken: event.authToken,
            context: event.context,
            map: event.map,
            paymentMap: event.paymentMap);
      }
      if (event is PayCashEvent) {
        String? userId =
            await const FlutterSecureStorage().read(key: StorageKeys.userId);
        event.map.addAll({
          "apartment": {"stringValue": apartmentController.text.trim()},
          "floor": {"stringValue": floorController.text.trim()},
          "country": {"stringValue": "EGP"},
          "postal_code": {"stringValue": postalCodeController.text},
          "first_name": {"stringValue": fristNameController.text},
          "last_name": {"stringValue": lastNameController.text},
          "email": {"stringValue": emailController.text},
          "phone_number": {"stringValue": "+2${phoneController.text}"},
          "building": {"stringValue": buildingtController.text.trim()},
          "street": {"stringValue": addressController.text},
          "shipping_method": {"stringValue": "PKG"},
          "city": {"stringValue": cityController.text.trim()},
          "state": {"stringValue": stateController.text.trim()},
          "payment_data": {
            "stringValue": json.encode({"success": "cash"}),
          },
          "user_id": {"stringValue": userId}
        });
        await createCashOrder(
            context: event.context, map: event.map, userId: userId);
      }
    });
  }
  bool isLoading = false;
  createCashOrder({required BuildContext context, map, userId}) async {
    isLoading = true;
    emit(SucessCreateState());
    try {
      await serviceLocator.get<DioConsumer>().post(
          "${EndPoints.firestoreBaseUrl}/order",
          body: {"fields": map}).whenComplete(() async {
        await serviceLocator
            .get<DioConsumer>()
            .get(
                "${EndPoints.firestoreBaseUrl}/${FirestoreKeys.cart}/$userId/${FirestoreKeys.cartProducts}")
            .then((value) {
          for (var element in List.from(value["documents"])) {
            serviceLocator.get<DioConsumer>().delete(
                "${EndPoints.firestoreBaseUrl}/${FirestoreKeys.cart}/$userId/${FirestoreKeys.cartProducts}/${element["name"].split("/").last}");
          }
        });
        AppcontrorllerCubit.get(context).getCartLenth();
      });
      isLoading = false;
      emit(SucessCreateState());
      appToast("Order Created Successfully");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomNavigationScreen(),
          ),
          (route) => false);
    } catch (e) {
      isLoading = false;
      emit(FailedCreateState(
          error: camilCaseMethod("Failed to create your order")));
    }
  }
}
