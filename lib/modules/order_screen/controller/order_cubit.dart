import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
 
import '../../../core/constants/storage_keys.dart'; 

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());
  static OrderCubit get(context) => BlocProvider.of(context);
  String? userId;
  bool isLoading=false;
  getUserDetails() async {
isLoading=true;
     emit(LoadidngGetOrdersState());
    FlutterSecureStorage storage = const FlutterSecureStorage();
    userId = await storage.read(key: StorageKeys.userId);
isLoading=false;

     emit(SuccessGetOrdersState());

   }
 
}
