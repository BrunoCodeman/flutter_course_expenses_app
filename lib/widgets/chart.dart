import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/transaction.dart';
import 'package:intl/intl.dart';

bool _dateMatcher(Transaction e, DateTime weekDay) {
  return e.date.day == weekDay.day &&
      e.date.month == weekDay.month &&
      e.date.year == weekDay.year;
}

class Chart extends StatelessWidget {
  const Chart(this.recentTransactions);
  final List<Transaction> recentTransactions;

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var sum = 0.0;
      for (Transaction e in recentTransactions) {
        if (_dateMatcher(e, weekDay)) {
          sum += e.amount;
        }
      }
      return {'day': DateFormat.E(weekDay), 'amount': sum};
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
          //children: [groupedTransacionValues.map((e) => Column())],
          ),
    );
  }
}
