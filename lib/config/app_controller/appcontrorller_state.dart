part of 'appcontrorller_cubit.dart';

abstract class AppcontrorllerState extends Equatable {
  const AppcontrorllerState();

  @override
  List<Object> get props => [];
}

class AppcontrorllerInitial extends AppcontrorllerState {} 
class GetProductState extends AppcontrorllerState {} 
class GetCartLengthState extends AppcontrorllerState {} 
class AddCartState extends AppcontrorllerState {} 

