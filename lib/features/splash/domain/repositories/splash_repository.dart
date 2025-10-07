import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class SplashRepository {
  Either<Failure, bool> isUserLoggedIn();
}
