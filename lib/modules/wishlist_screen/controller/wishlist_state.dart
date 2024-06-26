part of 'wishlist_cubit.dart';

abstract class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object> get props => [];
}

class WishlistInitial extends WishlistState {}
class LoadingGetWishlistState extends WishlistState {}

class GetUserIdState extends WishlistState {} 
