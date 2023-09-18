import 'package:dartz/dartz.dart';

import '../../api/exceptions.dart';

abstract class RegisterRepository{
  Future<Either<ServerException,String>>register({required String email,
      required String password,
      required String name,
      required String phone}  );
}