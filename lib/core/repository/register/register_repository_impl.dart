import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart'; 
import '../../api/exceptions.dart';
import 'register_repository.dart';

import '../../api/dio_consumer.dart';
import '../../api/end_points.dart';
import '../../constants/firestore_keys.dart';

class RegisterRepositoryImpl extends RegisterRepository {
  final DioConsumer dio;
  RegisterRepositoryImpl({required this.dio});
  @override
  Future<Either<ServerException, String>> register(
      {required String email,
      required String password,
      required String name,
      required String phone}) async {
    try {
      Map response = await dio.post(EndPoints.signUp, body: {
        "email": email,
        "password": password,
        "returnSecureToken": true
      });

      await saveUserInDataBase(
        email: email,
        name: name,
        phone: phone,
        uid: response["localId"],
      );
      return right("Email Create successfully");
    } catch (e) {
      if (e is DioError) {
        return left(dio.handleDioError(e));
      }   else {
        return left(ServerException(e.toString()));
      }
    }
  }

  Future<void> saveUserInDataBase(
      {required String email,
      required String name,
      required String uid,
      required String phone}) async {
 
      await dio.post(
          "${EndPoints.firestoreBaseUrl}/${FirestoreKeys.users}",
       
          body:    {
              'fields': {
                "email": {"stringValue":  email},
                "phone": {"stringValue":phone},
                "name": {"stringValue": name},
                "user_uid": {"stringValue":uid},
                "user_id": {
                  "stringValue":""
                },
                "image": {
                  "stringValue":  
                      'https://firebasestorage.googleapis.com/v0/b/have-fun-a5c87.appspot.com/o/userImg.png?alt=media&token=4f962df4-7c2d-4dd2-8950-f64e1ed9863d'
                }
              }
            });
  }
}
