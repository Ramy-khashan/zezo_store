part of 'order_cubit.dart';

class OrderState extends Equatable {
  final List<OrderModel> orders;
  final OperationStatus status;
  const OrderState(
      {this.orders = const [], this.status = OperationStatus.init});

  @override
  List<Object> get props => [status, orders];
  OrderState copyWith(
     {List<OrderModel> ?orders , OperationStatus? status}
  ){
    return OrderState(
      orders: orders??this.orders,
      status: status??this.status
    );
  }
}


 