import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/app_controller/appcontrorller_cubit.dart';
import 'core/constants/app_colors.dart';
import 'core/utils/functions/app_route.dart';

class ShopApp extends StatelessWidget {
  final AppRoute appRoute;
  const ShopApp({super.key, required this.appRoute});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppcontrorllerCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Zezo App',
        navigatorKey: ShopApp.navigatorKey,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.blackColor,
          primaryColor: Colors.blue,
          colorScheme: ThemeData().colorScheme.copyWith(
                secondary: const Color(0xFF1a1f3c),
                brightness: Brightness.dark,
              ),
          useMaterial3: true,
          brightness: Brightness.dark,
          cardColor: const Color(0xFF0a0d2c),
          canvasColor: AppColors.blackColor,
          buttonTheme: Theme.of(context)
              .buttonTheme
              .copyWith(colorScheme: const ColorScheme.dark()),
        ),
        onGenerateRoute: appRoute.routeGenrator,
      ),
    );
  }
}
