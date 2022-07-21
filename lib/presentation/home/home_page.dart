import 'package:clean_api/clean_api.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneybag/application/app/transaction/transaction_provider.dart';
import 'package:moneybag/application/app/transaction/transaction_state.dart';
import 'package:moneybag/application/auth/auth_provider.dart';
import 'package:moneybag/application/auth/auth_state.dart';
import 'package:moneybag/domain/app/user_profile.dart';
import 'package:moneybag/presentation/auth/login_page.dart';
import 'package:moneybag/presentation/home/transacion_dialogue.dart';
import 'package:moneybag/presentation/home/widget/top_part.dart';
import 'package:moneybag/presentation/home/widget/transaction_tile.dart';

class HomePage extends ConsumerWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final profile = ref.watch(authProvider.select((value) => value.profile));
    final transactions = ref.watch(transactionStreamProvider);

    ref.listen<AuthState>(authProvider, (previous, next) {
      if (previous?.profile != next.profile &&
          next.profile == UserProfile.empty()) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginPage()));
      }
    });
    ref.listen<TransactionState>(transactionProvider, (previous, next) {
      if (previous != next) {
        if (next.failure != CleanFailure.none()) {
          CleanFailureDialogue.show(context, failure: next.failure);
        }
      }
    });

    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        title: const Text('Money bag'),
      ),
      body: ListView(
        children: <Widget>[
          TopPart(profile),
          transactions.when(
              data: (list) => ListView.builder(
                  itemCount: list.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final transaction = list[index];
                    return TransactionTile(transaction);
                  }),
              error: (error, _) => Text(error.toString()),
              loading: () => const CircularProgressIndicator())
          // Text('data ${transactions.}')
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return const TransactionDialogue();
              });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
