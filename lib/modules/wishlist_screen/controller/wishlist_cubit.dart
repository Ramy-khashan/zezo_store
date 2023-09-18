import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; 
import '../../../core/constants/storage_keys.dart'; 

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(WishlistInitial());
  static WishlistCubit get(context) => BlocProvider.of(context);
  getUserDetails() async {
    emit(LoadingGetWishlistState());
    FlutterSecureStorage storage = const FlutterSecureStorage();
    userId = await storage.read(key: StorageKeys.userId);
    emit(GetUserIdState());
  }

  String? userId;

  deleteItem({required String productId}) async {
  await  FirebaseFirestore.instance
        .collection("favorite")
        .doc(userId)
        .collection("favorite_products")
        .doc(productId)
        .delete();
  }
}
