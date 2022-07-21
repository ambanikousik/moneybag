import 'package:clean_api/clean_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneybag/application/auth/auth_provider.dart';
import 'package:moneybag/application/auth/auth_state.dart';
import 'package:moneybag/domain/app/user_profile.dart';
import 'package:moneybag/domain/auth/login_body.dart';
import 'package:moneybag/presentation/auth/registration_page.dart';
import 'package:moneybag/presentation/auth/util/validation_rules.dart';
import 'package:moneybag/presentation/home/home_page.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final showPassword = useState(false);
    final formKey = useMemoized(() => GlobalKey<FormState>());

    final state = ref.watch(authProvider);

    ref.listen<AuthState>(authProvider, (previous, next) {
      if (previous != next && !next.loading) {
        if (next.failure != CleanFailure.none() ||
            next.profile == UserProfile.empty()) {
          if (next.failure != CleanFailure.none()) {
            Logger.e(next.failure);
            CleanFailureDialogue.show(context, failure: next.failure);
          }
        } else {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomePage()));
        }
      }
    });

    return Scaffold(
      body: state.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: formKey,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shrinkWrap: true,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 200, bottom: 40),
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  TextFormField(
                    controller: emailController,
                    validator: ValidationRules.email,
                    decoration: const InputDecoration(
                        labelText: 'Email',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple))),
                    enabled: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: !showPassword.value,
                    validator: ValidationRules.password,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        suffix: InkWell(
                          onTap: () {
                            showPassword.value = !showPassword.value;
                          },
                          child: showPassword.value
                              ? const Icon(
                                  CupertinoIcons.eye,
                                  color: Colors.deepPurple,
                                )
                              : const Icon(
                                  CupertinoIcons.eye_slash,
                                  color: Colors.grey,
                                ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple)),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple))),
                    enabled: true,
                  ),
                  const SizedBox(height: 80),
                  ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState?.validate() ?? false) {
                          ref.read(authProvider.notifier).login(LoginBody(
                              email: emailController.text,
                              password: passwordController.text));
                        }
                      },
                      child: const Text('Login')),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const RegistraionPage()));
                      },
                      child: const Text('Signup'))
                ],
              ),
            ),
    );
  }
}
