import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.deleteTransaction,
    required this.transaction,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeOfContext = Theme.of(context);
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      elevation: 5,
      child: ListTile(
        trailing: MediaQuery.of(context).size.width > 460
            ? TextButton.icon(
                onPressed: () => deleteTransaction(transaction.id),
                icon: Icon(Icons.delete),
                label: Text(
                  "delete",
                  style: TextStyle(color: themeOfContext.errorColor),
                ))
            : IconButton(
                icon: Icon(
                  Icons.delete,
                  color: themeOfContext.errorColor,
                ),
                onPressed: () => deleteTransaction(transaction.id),
                color: themeOfContext.errorColor,
              ),
        title: Text(
          transaction.title,
          style: themeOfContext.textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat('dd/MM/yyyy hh:mm').format(transaction.date),
        ),
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
              child: Text("\$ ${transaction.amount.toStringAsFixed(2)}"),
            ),
          ),
        ),
      ),
    );
  }
}
