part of 'reset_password_cubit.dart';

abstract class ResetPasswordState extends Equatable {
  const ResetPasswordState();

  @override
  List<Object> get props => [];
}

class ResetPasswordInitial extends ResetPasswordState {}
class LoadingResetPasswordState extends ResetPasswordState {}
class DoneResetPasswordState extends ResetPasswordState {}
class FailedResetPasswordState extends ResetPasswordState {}
