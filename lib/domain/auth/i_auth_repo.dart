import 'package:clean_api/clean_api.dart';
import 'package:moneybag/domain/app/user_profile.dart';
import 'package:moneybag/domain/auth/login_body.dart';
import 'package:moneybag/domain/auth/signup_body.dart';

abstract class IAuthRepo {
  TaskEither<CleanFailure, UserProfile> login(LoginBody body);

  TaskEither<CleanFailure, UserProfile> registration(SignupBody body);

  TaskEither<CleanFailure, UserProfile> checkAuth();

  Future<void> logout();
}
