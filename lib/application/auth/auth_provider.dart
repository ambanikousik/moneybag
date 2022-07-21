import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneybag/application/auth/auth_state.dart';
import 'package:moneybag/domain/auth/i_auth_repo.dart';
import 'package:moneybag/domain/auth/login_body.dart';
import 'package:moneybag/domain/auth/signup_body.dart';
import 'package:moneybag/infrastructure/auth/auth_repo.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(FirebaseAuthRepo());
});

class AuthNotifier extends StateNotifier<AuthState> {
  final IAuthRepo authRepo;
  AuthNotifier(this.authRepo) : super(AuthState.init());

  login(LoginBody body) async {
    state = AuthState.init().copyWith(loading: true);
    final reponse = await authRepo.login(body).run();

    state = reponse
        .fold((l) => state.copyWith(failure: l),
            (r) => state.copyWith(profile: r))
        .copyWith(loading: false);
  }

  registration(SignupBody body) async {
    state = AuthState.init().copyWith(loading: true);
    final reponse = await authRepo.registration(body).run();

    state = reponse
        .fold((l) => state.copyWith(failure: l),
            (r) => state.copyWith(profile: r))
        .copyWith(loading: false);
  }

  checkAuth() async {
    state = state.copyWith(loading: true);
    final reponse = await authRepo.checkAuth().run();

    state = reponse
        .fold((l) => state.copyWith(failure: l),
            (r) => state.copyWith(profile: r))
        .copyWith(loading: false);
  }

  logout() async {
    await authRepo.logout();

    state = AuthState.init();
  }
}
