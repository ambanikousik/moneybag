import 'package:clean_api/clean_api.dart';
import 'package:moneybag/domain/app/transaction.dart';

abstract class ITransactionRepo {
  TaskEither<CleanFailure, Unit> submitTransaction(
      {required Transaction transaction, required String uid});
}
