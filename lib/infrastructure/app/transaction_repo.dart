import 'package:clean_api/clean_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;

import 'package:moneybag/domain/app/i_transaction_repo.dart';
import 'package:moneybag/domain/app/transaction.dart';

class TransactionRepo extends ITransactionRepo {
  final db = FirebaseFirestore.instance;
  @override
  TaskEither<CleanFailure, Unit> submitTransaction(
          {required Transaction transaction, required String uid}) =>
      TaskEither.tryCatch(() async {
        await db
            .collection('User')
            .doc(uid)
            .collection('transactions')
            .add(transaction.toMap());
        return unit;
      },
          (error, stackTrace) =>
              CleanFailure(tag: 'Submit transaction', error: error.toString()));
}
