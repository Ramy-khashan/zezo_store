part of 'order_data_bloc.dart';
 
abstract class OrderPaymentDataState {}

class OrderDataInitial extends OrderPaymentDataState {}
class ShowHidePasswordState extends OrderPaymentDataState {}
class LoadingCreateState extends OrderPaymentDataState {}
class SucessCreateState extends OrderPaymentDataState {}
class FailedCreateState extends OrderPaymentDataState {
final String error;

  FailedCreateState({required this.error});
}
