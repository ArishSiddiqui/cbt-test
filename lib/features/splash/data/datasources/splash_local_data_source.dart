import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_constants.dart';

abstract class SplashLocalDataSource {
  bool isUserLoggedIn();
}

class SplashLocalDataSourceImpl implements SplashLocalDataSource {
  final SharedPreferences sharedPreferences;

  SplashLocalDataSourceImpl({required this.sharedPreferences});

  @override
  bool isUserLoggedIn() {
    final bool? isLoggedIn = sharedPreferences.getBool(isLoggedInKey);
    final String? userID = sharedPreferences.getString(userUIDKey);
    userUID = userID;
    return isLoggedIn ?? false;
  }
}
