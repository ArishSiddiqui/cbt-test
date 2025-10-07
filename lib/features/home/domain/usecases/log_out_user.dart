import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class LogOutUser implements Usecase<bool, NoParams> {
  final AuthRepository repository;
  LogOutUser(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams noParams) async {
    return await repository.logout();
  }
}
