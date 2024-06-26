part of 'special_order_request_cubit.dart';

abstract class SpecialOrderRequestState extends Equatable {
  const SpecialOrderRequestState();

  @override
  List<Object> get props => [];
}

class SpecialOrderRequestInitial extends SpecialOrderRequestState {}
class GetUserIdState extends SpecialOrderRequestState {} 
