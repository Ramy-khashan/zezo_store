part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class RemoveCartState extends CartState {}

class AddingCartState extends CartState {}

class ClearCartState extends CartState {}
class LoadingGetCartState extends CartState {}

class SucessGetCartState extends CartState {}

class FailedGetCartState extends CartState {}
class RemoveItemFromCartState extends CartState {}
