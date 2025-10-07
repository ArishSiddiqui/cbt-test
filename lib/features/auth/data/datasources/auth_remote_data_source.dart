import 'package:cbt_test/core/error/exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_constants.dart';

abstract class AuthRemoteDataSource {
  Future<UserCredential> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  });
  Future<UserCredential> login(String email, String password);
  Future<bool> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SharedPreferences sharedPreferences;
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  AuthRemoteDataSourceImpl({
    required this.sharedPreferences,
    required this.firestore,
    required this.firebaseAuth,
  });

  @override
  Future<UserCredential> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    final userCredential = await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .timeout(
          timeoutDuration,
          onTimeout: () {
            throw ServerException(connectionTimeOutMessage);
          },
        );

    final user = userCredential.user!;
    final uid = user.uid;

    // Save user info to Firestore
    await firestore
        .collection(userDB)
        .doc(uid)
        .set({
          'uid': uid,
          'email': email,
          'firstName': firstName,
          'lastName': lastName,
          'createdAt': FieldValue.serverTimestamp(),
        })
        .timeout(
          timeoutDuration,
          onTimeout: () {
            throw ServerException(
              'Saving user data timed out. Please try again.',
            );
          },
        );

    await sharedPreferences.setBool(isLoggedInKey, true);
    await sharedPreferences.setString(userUIDKey, uid);
    return userCredential;
  }

  @override
  Future<UserCredential> login(String email, String password) async {
    final userCredential = await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .timeout(
          timeoutDuration,
          onTimeout: () {
            throw ServerException(connectionTimeOutMessage);
          },
        );

    final user = userCredential.user!;
    final uid = user.uid;

    await sharedPreferences.setBool(isLoggedInKey, true);
    await sharedPreferences.setString(userUIDKey, uid);
    return userCredential;
  }

  @override
  Future<bool> logout() async {
    await firebaseAuth.signOut().timeout(
      timeoutDuration,
      onTimeout: () {
        throw ServerException(connectionTimeOutMessage);
      },
    );
    await sharedPreferences.setString(userUIDKey, "");
    return await sharedPreferences.setBool(isLoggedInKey, false);
  }
}
