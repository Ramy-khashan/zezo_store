part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}
class ShowPasswordState extends LoginState {}

class LoadingLoginState extends LoginState {} 
class FaildLoginState extends LoginState {} 
class SuccessgLoginState extends LoginState {}
 class LoadingSignInGoogleState extends LoginState {} 
class FaildSignInGoogleState extends LoginState {} 
class SuccessgSignInGoogleState extends LoginState {} 
