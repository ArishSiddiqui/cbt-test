import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/home_repository.dart';

class DeleteTask implements Usecase<void, DeleteTaskParams> {
  final HomeRepository repository;
  DeleteTask(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteTaskParams params) async {
    return await repository.deleteTask(params.taskId);
  }
}

class DeleteTaskParams extends Equatable {
  final String taskId;

  const DeleteTaskParams({required this.taskId});

  @override
  List<Object?> get props => [taskId];
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
