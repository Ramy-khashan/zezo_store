part of 'order_payment_cubit.dart';

sealed class OrderPaymentState extends Equatable {
  const OrderPaymentState();

  @override
  List<Object> get props => [];
}

final class OrderPaymentInitial extends OrderPaymentState {}
class ShowHidePasswordState extends OrderPaymentState {}
class LoadingCreateState extends OrderPaymentState {}
class GetUserDataState extends OrderPaymentState {}
class SucessCreateState extends OrderPaymentState {}
class FailedCreateState extends OrderPaymentState {}



final class LoadingGetDeliveryAddressState   extends OrderPaymentState {}
final class GetDeliveryAddressState extends OrderPaymentState {}
final class FailedGetDeliveryAddressState extends OrderPaymentState {}
final class SelectedDeliveryAddressState extends OrderPaymentState {}
 final class ToggleDeliveryAddressState extends OrderPaymentState {}
 