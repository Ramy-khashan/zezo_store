import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/app_controller/appcontrorller_cubit.dart';
import 'config/changetheme/changetheme_cubit.dart';
import 'config/changetheme/changetheme_states.dart';
import 'core/constants/theme.dart';
import 'core/utils/functions/app_route.dart';

class ShopApp extends StatelessWidget {
  final AppRoute appRoute;
  const ShopApp({super.key, required this.appRoute});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppcontrorllerCubit(),
        ),
        BlocProvider(
          create: (context) => ChangeTheme()..savedTheme(),
        )
      ],
      child: BlocBuilder<ChangeTheme, ChangeThemeState>(
        builder: (context, state) {
          final controller = ChangeTheme.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Zezo App',
            navigatorKey: ShopApp.navigatorKey,
            theme: light,
            darkTheme: dark,
            themeMode: controller.themeMode ?? ThemeMode.system,
            onGenerateRoute: (settings) =>
                appRoute.routeGenrator(settings, controller.userId),
          );
        },
      ),
    );
  }
}
