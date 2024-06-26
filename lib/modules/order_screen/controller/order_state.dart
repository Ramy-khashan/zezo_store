part of 'order_cubit.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}
class LoadidngGetOrdersState extends OrderState {}
class SuccessGetOrdersState extends OrderState {}
