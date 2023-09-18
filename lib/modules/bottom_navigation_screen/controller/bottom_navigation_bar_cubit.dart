import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../core/widgets/need_login_model_sheet.dart';
import '../../../core/constants/storage_keys.dart';

import '../../../core/repository/cart_process/cart_process_repo_impl.dart';
import '../../../core/widgets/not_sign_in.dart';
import '../../Category_Screen/view/category_screen.dart';
import '../../Home_Screen/view/home_screen.dart';
import '../../cart_screen/view/cart_screen.dart';
import '../../setting/view/setting_screen.dart';
import '../../special_order/view/special_order_screen.dart';

part 'bottom_navigation_bar_state.dart';

class BottomNavigationBarCubit extends Cubit<BottomNavigationBarState> {
  BottomNavigationBarCubit() : super(BottomNavigationBarInitial());

  static BottomNavigationBarCubit get(context) => BlocProvider.of(context);
  bool isLoading = true;
  getDetails() async {
    userId = await const FlutterSecureStorage().read(key: StorageKeys.userId);
    isLoading = false;
    pages = [
      const HomeScreen(),
      const CategoryScreen(),
      userId == null ? const NotSignPage() : const SpecialOrderScreen(),
      userId == null ? const NotSignPage() : const CartScreen(),
      userId == null ? const NotSignPage() : const SettingsSCreen(),
    ];
    emit(GetUserDataState());
  }

  int cartLength = 0;
  getCartLenth({required String userId}) async {
    String? userIdValue =
        await const FlutterSecureStorage().read(key: StorageKeys.userId);
    if (userIdValue != null) {
      final res =
          await CartProcessRepositoryImpl().cartLength(userId: userIdValue);
      res.fold((l) => cartLength = l, (r) => cartLength = r);
      emit(GetCartLengthState());
    }
  }

  String? userId;
  int currentIndex = 0;
  void selectedPage(int value, context) {
    emit(BottomNavigationBarInitial());

    currentIndex = value;
    if (userId == null && (value == 2 || value == 3 || value == 4)) {
      needLogin(context: context);
    }
    emit(ChangePagesState());
  }

  List<Widget> pages = [];
}
