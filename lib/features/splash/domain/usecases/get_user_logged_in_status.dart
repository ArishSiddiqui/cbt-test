import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/splash_repository.dart';

class GetUserLoggedInStatus implements Usecase<bool, NoParams> {
  final SplashRepository repository;
  GetUserLoggedInStatus(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams noParams) async {
    return Future.value(repository.isUserLoggedIn());
  }
}
