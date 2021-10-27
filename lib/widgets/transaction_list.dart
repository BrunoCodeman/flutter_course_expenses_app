import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  const TransactionList({required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text(
                  "No transactions to show",
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    "assets/images/waiting.png",
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  elevation: 5,
                  child: ListTile(
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat('dd/MM/yyyy hh:mm')
                          .format(transactions[index].date),
                    ),
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                              "\$ ${transactions[index].amount.toStringAsFixed(2)}"),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
