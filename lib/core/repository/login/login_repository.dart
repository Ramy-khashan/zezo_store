import 'package:dartz/dartz.dart';
 import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../../../modules/login/model/user.dart';
import '../../api/exceptions.dart';

abstract class LoginRepository {
  Future<Either<ServerException, String>> signIn(
      {required String email, required String password, context}); 
  Future<Either<String, String>> signInWithGoogle(context); 
    Future<User?> get user;
  Future<LoginResult> logIn();
  Future<void> logOut();
}
