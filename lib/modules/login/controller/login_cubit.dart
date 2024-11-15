import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../../../core/constants/route_key.dart';
import '../../../core/notification/notification_services.dart';
import '../../../core/repository/login/login_repository_impl.dart';
import '../../../core/utils/functions/app_toast.dart';
import '../../bottom_navigation_screen/view/bottom_navigation_screen.dart';

part 'login_state.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await NotificationService().initNotification();

  NotificationService().showNotification(
      3, message.notification!.title!, message.notification!.body!);

  debugPrint('Handling a background message ${message.messageId}');
}

class LoginCubit extends Cubit<LoginState> {
  final LoginRepositoryImpl loginRepositoryImpl;

  LoginCubit(this.loginRepositoryImpl) : super(LoginInitial());
  getNotification() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
      FirebaseMessaging.instance.subscribeToTopic("users");
     NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    if (kDebugMode) {
      print('User granted permission: ${settings.authorizationStatus}');
    }
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await NotificationService().initNotification();

      NotificationService().showNotification(
          4, message.notification!.title!, message.notification!.body!);
    });
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  static LoginCubit get(context) => BlocProvider.of(context);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  final formKeyLogin = GlobalKey<FormState>();

  bool obscureText = true;
  bool isLoadginEmail = false;
  void onSubmitLogin(BuildContext context) async {
    FocusScope.of(context).unfocus();

    if (formKeyLogin.currentState!.validate()) {
      isLoadginEmail = true;
      emit(LoadingLoginState());
      final res = await loginRepositoryImpl.signIn(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      res.fold((l) {
        isLoadginEmail = false;
        emit(FaildLoginState());
        appToast(l.message.toString());
      }, (r) {
        isLoadginEmail = false;
        emit(SuccessgLoginState());
        Navigator.pushNamedAndRemoveUntil(
            context, RouteKeys.homeScreen, (route) => false);
      });
    }
  }

  void onTapSuffix() {
    emit(LoginInitial());

    obscureText = !obscureText;
    emit(ShowPasswordState());
  }

  bool isLoadingSignInGoogle = false;
  signInWithGoogle(context) async {
    isLoadingSignInGoogle = true;
    emit(LoadingSignInGoogleState());
    var response = await loginRepositoryImpl.signInWithGoogle(context);
    response.fold((l) {
      appToast(l.toString());
      isLoadingSignInGoogle = false;
      emit(FaildSignInGoogleState());
    }, (r) {
      isLoadingSignInGoogle = false;
      emit(SuccessgSignInGoogleState());
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomNavigationScreen(),
          ),
          (route) => false);
    });
  }

  bool isLoggedIn = false;
  Map userObj = {};
  signInWithFacebook(context) async {
   await FacebookAuth.i
        .login(permissions: ["public_profile", "email"]).then((value) {
      FacebookAuth.instance.getUserData().then((userData) {
        isLoggedIn = true;
        userObj = userData;
      });
    });
  }
}
