import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/error/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserCredential>> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  });
  Future<Either<Failure, UserCredential>> login(String email, String password);
  Future<Either<Failure, bool>> logout();
}
