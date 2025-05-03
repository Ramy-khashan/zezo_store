part of 'settings_cubit.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}
class GetUserDataState extends SettingsState {}
class DeletedState extends SettingsState {}
class LoadingDeleteState   extends SettingsState {}
class FailedDeleteState extends SettingsState {}
class GetDeleteAccountState extends SettingsState {}
class ChangeVisiability extends SettingsState {}

