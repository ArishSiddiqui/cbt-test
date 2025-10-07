import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class LogInUser implements Usecase<UserCredential, LoginUserParams> {
  final AuthRepository repository;
  LogInUser(this.repository);

  @override
  Future<Either<Failure, UserCredential>> call(LoginUserParams params) async {
    return await repository.login(params.email, params.password);
  }
}

class LoginUserParams extends Equatable {
  final String email;
  final String password;
  const LoginUserParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
