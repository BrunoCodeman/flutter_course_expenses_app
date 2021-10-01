import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function newTransaction;
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  NewTransaction({required this.newTransaction});

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
              keyboardType: TextInputType.number,
              controller: amountController,
            ),
            TextButton(
              onPressed: () {
                this.newTransaction(
                  titleController.text,
                  double.parse(amountController.text),
                );
              },
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
