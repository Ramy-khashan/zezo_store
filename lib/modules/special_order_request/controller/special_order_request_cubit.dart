import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; 
import '../../../core/constants/storage_keys.dart'; 
part 'special_order_request_state.dart';

class SpecialOrderRequestCubit extends Cubit<SpecialOrderRequestState> {
  SpecialOrderRequestCubit() : super(SpecialOrderRequestInitial());
  static SpecialOrderRequestCubit get(context) => BlocProvider.of(context);
  bool isLoading = false;
  getUser() async {
    emit(SpecialOrderRequestInitial());

    userId = await const FlutterSecureStorage().read(key: StorageKeys.userId);
    emit(GetUserIdState());
  }

  String? userId;
   
}
