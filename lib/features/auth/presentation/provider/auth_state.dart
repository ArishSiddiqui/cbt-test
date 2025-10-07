import 'package:equatable/equatable.dart';

import '../../../../core/constants/app_constants.dart';

class AuthState extends Equatable {
  final ApiStatus status;
  const AuthState({this.status = ApiStatus.initial});

  AuthState copywith({ApiStatus? status}) {
    return AuthState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
