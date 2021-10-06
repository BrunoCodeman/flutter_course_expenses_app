import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NewTransaction extends StatefulWidget {
  final Function newTransaction;

  NewTransaction({required this.newTransaction});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void _saveData() {
    final amount = double.parse(amountController.text);
    if (amount < 0 || titleController.text.isEmpty) {
      return;
    }

    this.widget.newTransaction(
          titleController.text,
          double.parse(amountController.text),
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
            TextButton(
              onPressed: _saveData,
              child: Text(
                'Add Transaction',
                style: TextStyle(
                  color: Colors.purple,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
