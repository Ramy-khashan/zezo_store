part of 'payment_bloc.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {}

class SetUrlState extends PaymentState {}
class OnProgressChangedState extends PaymentState {}

class OnLoadStartState extends PaymentState {}

class OnLoadStopState extends PaymentState {}
