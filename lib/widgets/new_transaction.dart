import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function newTransaction;

  NewTransaction({required this.newTransaction});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _transactionDate;
  void _showDatePicker() {
    showDatePicker(
            context: this.context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) => _transactionDate =
            pickedDate == null ? _transactionDate : pickedDate);
  }

  void _saveData() {
    final amount = double.parse(amountController.text);
    if (amount < 0 ||
        titleController.text.isEmpty ||
        _transactionDate == null) {
      return;
    }

    this.widget.newTransaction(
          titleController.text,
          double.parse(amountController.text),
          _transactionDate,
        );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: amountController,
              onSubmitted: (_) => _saveData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Text(_transactionDate == null
                      ? "No date chosen"
                      : DateFormat.yMd().format(_transactionDate!)),
                  TextButton(
                    onPressed: _showDatePicker,
                    child: Text(
                      "Choose date",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _saveData,
              child: Text(
                'Add Transaction',
                style: TextStyle(
                  color: Theme.of(context).textTheme.button!.color,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
