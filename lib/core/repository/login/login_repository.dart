import 'package:dartz/dartz.dart';

import '../../api/exceptions.dart';

abstract class LoginRepository {
  Future<Either<ServerException, String>> signIn(
      {required String email, required String password, context}); 
  Future<Either<String, String>> signInWithGoogle(context);
}
