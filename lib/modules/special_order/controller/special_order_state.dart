part of 'special_order_cubit.dart';

abstract class SpecialOrderState extends Equatable {
  const SpecialOrderState();

  @override
  List<Object> get props => [];
}

class SpecialOrderInitial extends SpecialOrderState {}

class GetDataState extends SpecialOrderState {}

class LoadingSpecialOrderState extends SpecialOrderState {}

class SuccessSpecialOrderState extends SpecialOrderState {}

class FailedSpecialOrderState extends SpecialOrderState {}
