part of 'order_process_cubit.dart';

abstract class OrderProcessState extends Equatable {
  const OrderProcessState();

  @override
  List<Object> get props => [];
}

class OrderProcessInitial extends OrderProcessState {}
class ChangValueState extends OrderProcessState {}
class GetDeliveryFeesLoadingState extends OrderProcessState {}
class GetDeliveryFeesState extends OrderProcessState {}
class LoadingCreateORdereState extends OrderProcessState {}
class SuccessCreateORdereState extends OrderProcessState {}
class FailedCreateORdereState extends OrderProcessState {
  final String error;

  const FailedCreateORdereState({required this.error});
}
