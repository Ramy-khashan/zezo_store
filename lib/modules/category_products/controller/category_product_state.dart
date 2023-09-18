part of 'category_product_cubit.dart';

abstract class CategoryProductState extends Equatable {
  const CategoryProductState();

  @override
  List<Object> get props => [];
}

class CategoryProductInitial extends CategoryProductState {}
class LoadidngGetProductState extends CategoryProductState {}
class SuccessGetProductState extends CategoryProductState {}
class SuccessLoadMoreState extends CategoryProductState {}
class LoadidngLoadMoreState extends CategoryProductState {}
class FailedGetProductState extends CategoryProductState {
  final String error;

  const FailedGetProductState({required this.error});
}
