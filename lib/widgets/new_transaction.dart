import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function newTransaction;
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  NewTransaction({required this.newTransaction});

  void _saveData() {
    final amount = double.parse(amountController.text);
    if (amount < 0 || titleController.text.isEmpty) {
      return;
    }

    this.newTransaction(
      titleController.text,
      double.parse(amountController.text),
    );
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
