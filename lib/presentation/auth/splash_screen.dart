import 'package:clean_api/clean_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneybag/application/auth/auth_provider.dart';
import 'package:moneybag/application/auth/auth_state.dart';
import 'package:moneybag/domain/app/user_profile.dart';
import 'package:moneybag/presentation/auth/login_page.dart';
import 'package:moneybag/presentation/home/home_page.dart';

class SplashScreen extends HookConsumerWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () {
        ref.read(authProvider.notifier).checkAuth();
      });
      return null;
    }, []);

    ref.listen<AuthState>(authProvider, (previous, next) {
      if (previous != next && !next.loading) {
        if (next.failure != CleanFailure.none() ||
            next.profile == UserProfile.empty()) {
          if (next.failure != CleanFailure.none()) {
            Logger.e(next.failure);
          }
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoginPage()));
        } else {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomePage()));
        }
      }
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Money_Bag',
              style: TextStyle(color: Colors.deepPurple, fontSize: 40),
            ),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
