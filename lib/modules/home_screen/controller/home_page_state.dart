part of 'home_page_cubit.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object> get props => [];
}

class HomePageInitial extends HomePageState {}

class LoadidngGetAllProductState extends HomePageState {}

class SuccessGetAllProductState extends HomePageState {}

class FailedGetAllProductState extends HomePageState {
  final String error;

  const FailedGetAllProductState({required this.error});
}

class LoadidngGetOnSaleProductState extends HomePageState {}

class SuccessGetOnSaleProductState extends HomePageState {}

class FailedGetOnSaleProductState extends HomePageState {
  final String error;

  const FailedGetOnSaleProductState({required this.error});
}

class LoadidngGetAdsState extends HomePageState {}

class SuccessGetAdsState extends HomePageState {}

class FailedGetAdsState extends HomePageState {
  final String error;

  const FailedGetAdsState({required this.error});
}

class LoadingAddCartState extends HomePageState {}

class SuccessAddCartState extends HomePageState {}

class FailedAddcartState extends HomePageState {}
