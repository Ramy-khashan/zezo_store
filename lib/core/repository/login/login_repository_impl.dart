import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../modules/login/model/google_signin_model.dart';
import '../../api/dio_consumer.dart';
import '../../api/end_points.dart';
import '../../api/exceptions.dart';
import '../../constants/firestore_keys.dart';
import '../../constants/storage_keys.dart';
import '../../utils/functions/locator_service.dart';
import 'login_repository.dart';

class LoginRepositoryImpl extends LoginRepository {
  final DioConsumer dio;

  LoginRepositoryImpl({required this.dio});

  @override
  Future<Either<ServerException, String>> signIn(
      {required String email, required String password, context}) async {
    try {
      var res = await serviceLocator.get<DioConsumer>().post(EndPoints.signIn,
          body: {
            "email": email,
            "password": password,
            "returnSecureToken": true
          });
      await setLocalData(uid: res["localId"], context: context);
      if (kDebugMode) {
        print("idToken : ${res["idToken"]}");
      }
      await const FlutterSecureStorage()
          .write(key: StorageKeys.idToken, value: res["idToken"]);
      await const FlutterSecureStorage()
          .write(key: StorageKeys.isGoogleSign, value: "false");
      return right("");
    } catch (e) {
      if (e is DioError) {
        return left(dio.handleDioError(e));
      } else {
        return left(const ServerException("Invalid email or password"));
      }
    }
  }

  setLocalData({required String uid, context}) async {
    var storage = const FlutterSecureStorage();
    final res = await serviceLocator
        .get<DioConsumer>()
        .post("${EndPoints.firestoreBaseUrl}:runQuery", body: {
      "structuredQuery": {
        "from": [
          {"collectionId": FirestoreKeys.users}
        ],
        "where": {
          "fieldFilter": {
            "field": {"fieldPath": "user_uid"},
            "op": "EQUAL",
            "value": {"stringValue": uid}
          }
        }
      }
    });
    storage.write(
        key: StorageKeys.userEmail,
        value: res[0]["document"]["fields"]["email"]["stringValue"]);
    storage.write(
        key: StorageKeys.userName,
        value: res[0]["document"]["fields"]["name"]["stringValue"]);
    storage.write(
        key: StorageKeys.userPhone,
        value: res[0]["document"]["fields"]["phone"]["stringValue"]);
    storage.write(
        key: StorageKeys.userUid,
        value: res[0]["document"]["fields"]["user_uid"]["stringValue"]);
    storage.write(
        key: StorageKeys.userImage,
        value: res[0]["document"]["fields"]["image"]["stringValue"]);
    storage.write(
        key: StorageKeys.userId,
        value: res[0]["document"]["name"].toString().split("/").last);
  }

  @override
  Future<Either<String, String>> signInWithGoogle(context) async {
     try {
      GoogleSignIn signInGoogle = GoogleSignIn(
          clientId:  "935517971692-tolf28l4c8te1k0f4l1safnns2upmrcl.apps.googleusercontent.com",
          scopes: ["email", "profile"]);
      signInGoogle.signOut();
      
      GoogleSignInAccount? googleSignInAccount = await signInGoogle.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      var res = await serviceLocator
          .get<DioConsumer>()
          .post(EndPoints.signGoogle, body: {
        'postBody':
            'id_token=${googleSignInAuthentication.idToken}&providerId=google.com',
        'requestUri': 'http://localhost',
        'returnIdpCredential': true,
        'returnSecureToken': true,
      });
      GoogleSignInModel googleSignInModel = GoogleSignInModel.fromJson(res);

      await setDataFromGoogle(userData: googleSignInModel, context: context);
      await const FlutterSecureStorage()
          .write(key: StorageKeys.isGoogleSign, value: "true");
      return right("Sing In Successfully");
    } catch (e) {
      log(e.toString());
      return left("Faild To Sign In");
    }
  }

  setDataFromGoogle({required GoogleSignInModel userData, context}) async {
    final res = await serviceLocator
        .get<DioConsumer>()
        .post("${EndPoints.firestoreBaseUrl}:runQuery", body: {
      "structuredQuery": {
        "from": [
          {"collectionId": FirestoreKeys.users}
        ],
        "where": {
          "fieldFilter": {
            "field": {"fieldPath": "user_uid"},
            "op": "EQUAL",
            "value": {"stringValue": userData.localId}
          }
        }
      }
    });

    if (!Map.from(res[0]).containsKey("document")) {
      String? userId;
      await serviceLocator.get<DioConsumer>().post(
          "${EndPoints.firestoreBaseUrl}/users",
          body: {}).then((value) async {
        userId = value["name"].toString().split("/").last;
        await serviceLocator.get<DioConsumer>().patch(
            "${EndPoints.firestoreBaseUrl}/users/${value["name"].toString().split("/").last}",
            body: {
              'fields': {
                "email": {"stringValue": userData.email},
                "phone": {"stringValue": "Not Exsist"},
                "name": {"stringValue": userData.displayName ?? "Name"},
                "user_uid": {"stringValue": userData.localId},
                "user_id": {
                  "stringValue": value["name"].toString().split("/").last
                },
                "image": {
                  "stringValue": userData.photoUrl ??
                      'https://firebasestorage.googleapis.com/v0/b/have-fun-a5c87.appspot.com/o/userImg.png?alt=media&token=4f962df4-7c2d-4dd2-8950-f64e1ed9863d'
                }
              }
            });
      });
      var storage = const FlutterSecureStorage();

      storage.write(key: StorageKeys.userEmail, value: userData.email);
      storage.write(
          key: StorageKeys.userName, value: userData.displayName ?? "Name");
      storage.write(key: StorageKeys.userPhone, value: "Not Exsist");
      storage.write(key: StorageKeys.userUid, value: userData.localId);
      storage.write(
          key: StorageKeys.userImage,
          value: userData.photoUrl ??
              'https://firebasestorage.googleapis.com/v0/b/have-fun-a5c87.appspot.com/o/userImg.png?alt=media&token=4f962df4-7c2d-4dd2-8950-f64e1ed9863d');

      storage.write(key: StorageKeys.userId, value: userId);
    } else {
      await setLocalData(uid: userData.localId!, context: context);
    }
  }
}
