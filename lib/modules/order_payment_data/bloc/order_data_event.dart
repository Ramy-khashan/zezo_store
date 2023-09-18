part of 'order_data_bloc.dart';

abstract class OrderPaymentDataEvent {}

class GoToPaymentEvent extends OrderPaymentDataEvent {
  final BuildContext context;
  final Map map;
  GoToPaymentEvent({required this.context, required this.map});
}

class PayCashEvent extends OrderPaymentDataEvent {
  final BuildContext context;
  final Map map;
  PayCashEvent({required this.context, required this.map});
}

class GetPaymentOrderIdEvent extends OrderPaymentDataEvent {
  final String authToken;
  final Map map;
  final Map paymentMap;
  // ignore: prefer_typing_uninitialized_variables
  final context;

  GetPaymentOrderIdEvent({
    required this.map,
    required this.paymentMap,
    required this.authToken,
    required this.context,
  });
}
