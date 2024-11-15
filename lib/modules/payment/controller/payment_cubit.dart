import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paymob_payment/paymob_payment.dart';
import 'package:store/core/api/end_points.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());
  static PaymentCubit get(context) => BlocProvider.of(context);
  PaymobResponse? paymobResponse;
  setResponse(response) {
    emit(PaymentInitial());
    paymobResponse = response;
    emit(SetPaymentResponseInitial());
  }

  initializePayment() async {
    PaymobPayment.instance.initialize(
      apiKey: EndPoints.apiToken,
      integrationID: EndPoints.integrationID,
      iFrameID: EndPoints.iFrameID,
    );
  }
}
