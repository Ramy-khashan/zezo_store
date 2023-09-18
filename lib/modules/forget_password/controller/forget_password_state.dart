part of 'forget_password_cubit.dart';

abstract class ForgetPasswordState extends Equatable {
  const ForgetPasswordState();

  @override
  List<Object> get props => [];
}

class ForgetPasswordInitial extends ForgetPasswordState {}
class SendOtpState extends ForgetPasswordState {}
class LoadingSendOtpState extends ForgetPasswordState {}
