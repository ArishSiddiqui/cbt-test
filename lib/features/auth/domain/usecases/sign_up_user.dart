import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class SignUpUser implements Usecase<UserCredential, SignUpUserParams> {
  final AuthRepository repository;
  SignUpUser(this.repository);

  @override
  Future<Either<Failure, UserCredential>> call(SignUpUserParams params) async {
    return await repository.signUp(
      email: params.email,
      firstName: params.firstName,
      lastName: params.lastName,
      password: params.password,
    );
  }
}

class SignUpUserParams extends Equatable {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  const SignUpUserParams({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });

  @override
  List<Object?> get props => [email, password, firstName, lastName];
}
