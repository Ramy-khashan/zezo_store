part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class PaymentResponseEvent extends PaymentEvent {
  final List<String> paymentList;
  final BuildContext context;
  final Map map;

  const PaymentResponseEvent(
    this.context, {
    required this.paymentList,
    required this.map,
  });
}
