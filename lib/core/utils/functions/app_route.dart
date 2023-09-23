import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../modules/All_Products_Screen/view/all_products_screen.dart';
import '../../../modules/bottom_navigation_screen/view/bottom_navigation_screen.dart';
import '../../../modules/category_products/view/category_product_scren.dart';
import '../../../modules/forget_password/view/forget_password.dart';
import '../../../modules/login/controller/login_cubit.dart';
import '../../../modules/login/view/login.dart';
import '../../../modules/order_screen/view/order_screen.dart';
import '../../../modules/product_details_screen/view/product_details_screen.dart';
import '../../../modules/register/controller/register_cubit.dart';
import '../../../modules/register/view/register.dart';
import '../../../modules/reports/view/reports_screen.dart';
import '../../../modules/reset_password/view/reset_password_screen.dart';
import '../../../modules/special_order_request/view/special_order_requests.dart';
import '../../../modules/splash_screen/view/splash_screen.dart';
import '../../../modules/wishlist_screen/view/wishlist_screen.dart';
import '../../constants/route_key.dart';
import '../../repository/login/login_repository_impl.dart';
import '../../repository/register/register_repository_impl.dart';
import 'locator_service.dart';

class AppRoute {
  Route? routeGenrator(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteKeys.allProductScreen:
        return MaterialPageRoute(
          builder: (context) => const AllProductScreen(),
        );

      case RouteKeys.loginScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => BlocProvider<LoginCubit>(
              create: (BuildContext _) =>
                  LoginCubit(serviceLocator.get<LoginRepositoryImpl>())..getNotification(),
              child: const LoginScreen()),
        );  case RouteKeys.resetPasswordScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const ResetPasswordScreen() 
        );
      case RouteKeys.homeScreen:
        return MaterialPageRoute(
          builder: (context) => const BottomNavigationScreen(),
        );case RouteKeys.reportsScreen:
        return MaterialPageRoute(
          builder: (context) => const ReportsScreen(),
        );
      case RouteKeys.specailOrder:
        return MaterialPageRoute(
          builder: (context) => const SpecialOrderRequests(),
        );
    

      case RouteKeys.forgetPasswordScreen:
        return MaterialPageRoute(
          builder: (context) => const ForgetPasswordScreen(),
        );

      case RouteKeys.registerScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => RegisterCubit(
                registerRepositoryImpl:
                    serviceLocator.get<RegisterRepositoryImpl>()),
            child: const RegisterScreen(),
          ),
        );

      case RouteKeys.ordersScreen:
        return MaterialPageRoute(
          builder: (context) => const OrdersScreen(),
        );

      case RouteKeys.productDetailsScreen:
        String productId = routeSettings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => ProductDetailsScreen(
            prouctId: productId,
          ),
        );

      case RouteKeys.wishListScreen:
        return MaterialPageRoute(
          builder: (context) => const WishListScreen(),
        );
      case RouteKeys.categoryProductScreen:
        String categoryId = routeSettings.arguments as String;
        String categoryName = routeSettings.arguments as String;
        return MaterialPageRoute(
          builder: (context) {
            return CategoryProductScreen(
              categoryId: categoryId,
              categoryName: categoryName,
            );
          },
        );
    }
    return MaterialPageRoute(
        builder: (BuildContext context) => const SplashScreen());
  }
}
