import 'package:cbt_test/core/error/exceptions.dart';
import 'package:cbt_test/core/error/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/constants/app_constants.dart';
import '../../domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserCredential>> login(
    String email,
    String password,
  ) async {
    try {
      final UserCredential userCredential = await remoteDataSource.login(
        email,
        password,
      );
      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      // Handle known Firebase Auth errors
      return Left(ServerFailure(_mapFirebaseErrorToMessage(e)));
    } on ServerException catch (e) {
      // Handle known Firebase Auth errors
      return Left(ServerFailure(e.message ?? unexpectedErrorMessage));
    } catch (e) {
      return Left(
        ServerFailure('An unexpected error occurred. Please try again.'),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      final bool loggedOut = await remoteDataSource.logout();
      return Right(loggedOut);
    } on FirebaseAuthException catch (e) {
      // Handle known Firebase Auth errors
      return Left(ServerFailure(_mapFirebaseErrorToMessage(e)));
    } on ServerException catch (e) {
      // Handle known Firebase Auth errors
      return Left(ServerFailure(e.message ?? unexpectedErrorMessage));
    } catch (e) {
      return Left(ServerFailure(unexpectedErrorMessage));
    }
  }

  @override
  Future<Either<Failure, UserCredential>> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      final UserCredential userCredential = await remoteDataSource.signUp(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
      );
      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      // Handle known Firebase Auth errors
      return Left(ServerFailure(_mapFirebaseErrorToMessage(e)));
    } on ServerException catch (e) {
      // Handle known Firebase Auth errors
      return Left(ServerFailure(e.message ?? unexpectedErrorMessage));
    } catch (e) {
      return Left(
        ServerFailure('An unexpected error occurred. Please try again.'),
      );
    }
  }

  String _mapFirebaseErrorToMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'This email address is already registered. Please try logging in instead.';
      case 'invalid-email':
        return 'The email address entered is not valid. Please check and try again.';
      case 'operation-not-allowed':
        return 'This operation is currently not allowed. Please contact support.';
      case 'weak-password':
        return 'Your password is too weak. Please choose a stronger password.';
      case 'too-many-requests':
        return 'Too many attempts detected. Please wait a moment before trying again.';
      case 'user-token-expired':
        return 'Your session has expired. Please log in again.';
      case 'network-request-failed':
        return 'Network error. Please check your internet connection and try again.';
      case 'user-not-found':
        return 'No account found for this email. Please check the email or sign up first.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'invalid-credential':
        return 'Invalid credentials provided. Please try again.';
      default:
        return 'Authentication failed. Please try again later.';
    }
  }
}
