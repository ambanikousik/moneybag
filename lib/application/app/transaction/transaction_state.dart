import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';

import 'package:moneybag/domain/app/transaction.dart';

class TransactionState extends Equatable {
  final CleanFailure failure;
  final List<Transaction> transactions;
  const TransactionState({
    required this.failure,
    required this.transactions,
  });

  TransactionState copyWith({
    CleanFailure? failure,
    List<Transaction>? transactions,
  }) {
    return TransactionState(
      failure: failure ?? this.failure,
      transactions: transactions ?? this.transactions,
    );
  }

  factory TransactionState.init() =>
      TransactionState(failure: CleanFailure.none(), transactions: const []);

  @override
  String toString() =>
      'TransactionState(failure: $failure, transactions: $transactions)';

  @override
  List<Object> get props => [failure, transactions];
}
