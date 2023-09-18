part of 'all_products_cubit.dart';

abstract class AllProductsState extends Equatable {
  const AllProductsState();

  @override
  List<Object> get props => [];
}

class AllProductsInitial extends AllProductsState {}

class OnPressState extends AllProductsState {}

class LoadidngGetAllProductState extends AllProductsState {}

class LoadidngLoadMoreState extends AllProductsState {}

class SuccessGetAllProductState extends AllProductsState {}

class SuccessLoadMoreState extends AllProductsState {}

class FailedGetAllProductState extends AllProductsState {
  final String error;

  const FailedGetAllProductState({required this.error});
}
