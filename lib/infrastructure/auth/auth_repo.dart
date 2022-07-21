import 'package:clean_api/clean_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart' hide Source;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moneybag/domain/app/source.dart';
import 'package:moneybag/domain/app/user_profile.dart';

import 'package:moneybag/domain/auth/i_auth_repo.dart';
import 'package:moneybag/domain/auth/signup_body.dart';
import 'package:moneybag/domain/auth/login_body.dart';

class FirebaseAuthRepo extends IAuthRepo {
  final auth = FirebaseAuth.instance;

  final db = FirebaseFirestore.instance;

  @override
  TaskEither<CleanFailure, UserProfile> login(LoginBody body) =>
      TaskEither.tryCatch(() async {
        final loginResponse = await auth.signInWithEmailAndPassword(
            email: body.email, password: body.password);

        if (loginResponse.user != null) {
          final data = await db
              .collection('User')
              .doc(loginResponse.user!.uid)
              .get()
              .then((value) => value.data());
          if (data != null) {
            final profile = UserProfile.fromMap(data);
            return profile;
          } else {
            throw 'Profile data was not found';
          }
        } else {
          throw 'Login was unsuccessfull, Something went wrong';
        }
      }, (error, _) => CleanFailure(tag: 'Login', error: error.toString()));

  @override
  TaskEither<CleanFailure, UserProfile> registration(SignupBody body) =>
      TaskEither.tryCatch(() async {
        final loginResponse = await auth.createUserWithEmailAndPassword(
            email: body.email, password: body.password);

        if (loginResponse.user != null) {
          final profile = UserProfile(
              name: body.name,
              id: loginResponse.user!.uid,
              email: body.email,
              sources: [Source(name: 'Cash', createdAt: DateTime.now())]);

          await db
              .collection('User')
              .doc(loginResponse.user!.uid)
              .set(profile.toMap());

          return profile;
        } else {
          throw 'Login was unsuccessfull, Something went wrong';
        }
      },
          (error, _) =>
              CleanFailure(tag: 'Registration', error: error.toString()));

  @override
  TaskEither<CleanFailure, UserProfile> checkAuth() =>
      TaskEither.tryCatch(() async {
        final user = auth.currentUser;

        if (user != null) {
          final data = await db
              .collection('User')
              .doc(user.uid)
              .get()
              .then((value) => value.data());
          if (data != null) {
            final profile = UserProfile.fromMap(data);
            return profile;
          } else {
            throw 'Profile data was not found for ${user.uid}';
          }
        } else {
          throw 'You are not logged in';
        }
      },
          (error, _) =>
              CleanFailure(tag: 'Check Auth', error: error.toString()));

  @override
  Future<void> logout() async {
    await auth.signOut();
  }
}
