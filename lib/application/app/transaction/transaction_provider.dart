import 'package:clean_api/clean_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneybag/application/app/transaction/transaction_state.dart';
import 'package:moneybag/application/auth/auth_provider.dart';
import 'package:moneybag/domain/app/i_transaction_repo.dart';
import 'package:moneybag/domain/app/transaction.dart';
import 'package:moneybag/infrastructure/app/transaction_repo.dart';

final transactionProvider =
    StateNotifierProvider<TransactionNotifier, TransactionState>((ref) {
  final uid = ref.watch(authProvider.select((value) => value.profile.id));
  return TransactionNotifier(uid, TransactionRepo());
});

class TransactionNotifier extends StateNotifier<TransactionState> {
  final String uid;
  final ITransactionRepo transactionRepo;
  TransactionNotifier(this.uid, this.transactionRepo)
      : super(TransactionState.init());

  submit(Transaction transaction) async {
    final data = await transactionRepo
        .submitTransaction(transaction: transaction, uid: uid)
        .run();

    state = state.copyWith(
        failure: data.fold((l) => l, (r) => CleanFailure.none()));
  }
}

final transactionStreamProvider = StreamProvider<List<Transaction>>((ref) {
  final uid = ref.watch(authProvider.select((value) => value.profile.id));

  return FirebaseFirestore.instance
      .collection('User')
      .doc(uid)
      .collection('transactions')
      .snapshots()
      .map((event) =>
          event.docs.map((e) => Transaction.fromMap(e.data())).toList());
});
