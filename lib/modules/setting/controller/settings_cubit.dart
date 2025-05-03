import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/constants/route_key.dart';
import '../../../core/constants/storage_keys.dart';
import '../../../core/utils/functions/validate.dart';
import '../../../core/utils/size_config.dart';
import '../../../core/widgets/textfield_item.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());
  static SettingsCubit get(context) => BlocProvider.of(context);

  getUserData() async {
    emit(SettingsInitial());

    email = await const FlutterSecureStorage().read(key: StorageKeys.userEmail);
    name = await const FlutterSecureStorage().read(key: StorageKeys.userName);
    image = await const FlutterSecureStorage().read(key: StorageKeys.userImage);
    isGoogleSign = await const FlutterSecureStorage()
                .read(key: StorageKeys.isGoogleSign) ==
            "false"
        ? false
        : true;

    emit(GetUserDataState());
  }

  bool hideDeleteAccount = true;
  getShowHideDeleteAccount() async {
    await FirebaseFirestore.instance
        .collection("configration")
        .doc("hideDeleteAccount")
        .get()
        .then((value) => hideDeleteAccount = value.get("hide"));
    emit(GetDeleteAccountState());
  }

  String? email = "";
  bool? isGoogleSign = false;
  String? name = "";
  String? image =
      "https://firebasestorage.googleapis.com/v0/b/zezo-store-32084.appspot.com/o/none.jpg?alt=media&token=10dee4a9-0256-4dad-8e6a-e7593af2e8b1";

  bool isLoadingDelete = false;
  deleteAccount(context) async {
    try {
      isLoadingDelete = true;
      emit(LoadingDeleteState());

      await showDeleteDialog(context);
      print("User account deleted successfully.");

      isLoadingDelete = false;
      emit(DeletedState());
    } on FirebaseAuthException catch (e) {
      print(e.message);
      isLoadingDelete = false;
      emit(FailedDeleteState());
    }
  }

  final formKeyLogin = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscureText = false;
  showDeleteDialog(
    context,
  ) async =>
      await showDialog(
          context: context,
          builder: (context) => AlertDialog.adaptive(
                title: Text("Delete Account"),
                content: Material(
                  color: Colors.transparent,
                  child: Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Form(
                          key: formKeyLogin,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFieldItem(
                                prefexIcon: Icons.email_outlined,
                                hintText: 'Email',
                                controller: emailController,
                                validator: (value) =>
                                    Validate.validateEmail(value!),
                                textInputAction: TextInputAction.next,
                                textInputType: TextInputType.emailAddress,
                              ),
                              SizedBox(
                                height: getHeight(20),
                              ),
                              TextFieldItem(
                                prefexIcon: Icons.password,
                                hintText: 'Password',
                                controller: passwordController,
                                obscureText: true,
                                validator: (value) => Validate.notEmpty(value!),
                                textInputAction: TextInputAction.done,
                                textInputType: TextInputType.visiblePassword,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () async {
                      if (formKeyLogin.currentState!.validate()) {
                        try {
                          final auth = FirebaseAuth.instance;
                          UserCredential? userCredential =
                              await auth.signInWithEmailAndPassword(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim());

                          userCredential.user!.delete().then((value) async {
                            await const FlutterSecureStorage()
                                .deleteAll()
                                .then((value) {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  RouteKeys.loginScreen, (route) => false);
                            });
                          });
                        } catch (e) {
                          print(e);
                        }
                      }
                    },
                    child: Text(
                      "Delete",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ));
}
