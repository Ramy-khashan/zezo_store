part of 'delivery_address_cubit.dart';

sealed class DeliveryAddressState extends Equatable {
  const DeliveryAddressState();

  @override
  List<Object> get props => [];
}

final class DeliveryAddressInitial extends DeliveryAddressState {}
final class LoadingGetDeliveryAddressState extends DeliveryAddressState {}
final class GetDeliveryAddressState extends DeliveryAddressState {}
final class FailedGetDeliveryAddressState extends DeliveryAddressState {}
