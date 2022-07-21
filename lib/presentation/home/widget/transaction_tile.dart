import 'package:flutter/material.dart';
import 'package:moneybag/domain/app/transaction.dart';

class TransactionTile extends StatelessWidget {
  final Transaction transaction;
  const TransactionTile(this.transaction, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
      child: ListTile(
        tileColor: Colors.white,
        leading: Icon(
          Icons.add_circle_outline,
          color: transaction.transactionType == 'expense'
              ? Colors.red
              : Colors.green,
        ),
        title: Text(
          'BDT ${transaction.amount.toString()}',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: transaction.transactionType == 'expense'
                  ? Colors.red
                  : Colors.green),
        ),
        subtitle: Text(transaction.source),
      ),
    );
  }
}
