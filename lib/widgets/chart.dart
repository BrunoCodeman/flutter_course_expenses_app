import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/transaction.dart';
import 'package:flutter_complete_guide/widgets/chart_bar.dart';
import 'package:intl/intl.dart';

bool _dateMatcher(Transaction e, DateTime weekDay) =>
    e.date.day == weekDay.day &&
    e.date.month == weekDay.month &&
    e.date.year == weekDay.year;

class Chart extends StatelessWidget {
  const Chart(this.recentTransactions);
  final List<Transaction> recentTransactions;

  double get totalSpending => groupedTransactionValues.fold(
      0.0, (sum, item) => sum + (item['amount'] as double));

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var sum = 0.0;
      for (Transaction e in recentTransactions) {
        if (_dateMatcher(e, weekDay)) {
          sum += e.amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': sum
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    //print(groupedTransactionValues.toString());
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues
              .map(
                (e) => Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                      e['day'].toString(),
                      (e['amount'] as double),
                      totalSpending == 0
                          ? 0.0
                          : ((e['amount'] as double) / totalSpending)),
                ),
              )
              .toList()
              .reversed
              .toList(),
        ),
      ),
    );
  }
}
