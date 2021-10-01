import 'package:flutter/material.dart';

import '../transaction.dart';
import 'new_transaction.dart';
import 'transaction_list.dart';

class UserTransactions extends StatefulWidget {
  const UserTransactions({Key? key}) : super(key: key);

  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _transactions = [
    Transaction(
      id: "1",
      title: "New Shoes",
      amount: 70,
      date: DateTime.now(),
    ),
    Transaction(
      id: "2",
      title: "Pizza",
      amount: 5,
      date: DateTime.now(),
    ),
  ];

  void _addNewTransaction(String title, double amount) {
    final date = DateTime.now();
    final t = Transaction(
        id: date.toString(), title: title, amount: amount, date: date);
    setState(() {
      _transactions.add(t);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(
          newTransaction: this._addNewTransaction,
        ),
        TransactionList(transactions: _transactions)
      ],
    );
  }
}
