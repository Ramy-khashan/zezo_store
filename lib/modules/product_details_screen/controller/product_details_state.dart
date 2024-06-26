part of 'product_details_cubit.dart';

abstract class ProductDetailsState extends Equatable {
  const ProductDetailsState();

  @override
  List<Object> get props => [];
}

class ProductDetailsInitial extends ProductDetailsState {}

class RemoveCartState extends ProductDetailsState {}

class AddingCartState extends ProductDetailsState {}

class LoadingGetProductState extends ProductDetailsState {}

class SuccessGetProductState extends ProductDetailsState {}

class FailedGetProductState extends ProductDetailsState {
  final String error;

  const FailedGetProductState({required this.error});
}

class LoadingAddCartState extends ProductDetailsState {}

class SuccessAddCartState extends ProductDetailsState {}

class FailedAddcartState extends ProductDetailsState {}
