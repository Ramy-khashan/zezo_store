part of 'add_edit_address_cubit.dart';

sealed class AddEditAddressState extends Equatable {
  const AddEditAddressState();

  @override
  List<Object> get props => [];
}

final class AddEditAddressInitial extends AddEditAddressState {}
final class LoadingAddEditAddEditAddressState extends AddEditAddressState {}
final class AddEditAddEditAddressState extends AddEditAddressState {}
final class FailedAddEditAddEditAddressState extends AddEditAddressState {}