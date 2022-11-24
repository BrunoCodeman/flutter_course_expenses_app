import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/adaptive_flat_button.dart';
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
    final amount = double.tryParse(amountController.text);
    if (amount == null ||
        amount < 0 ||
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
    final themeOfContext = Theme.of(context);

    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            top: 10,
            left: 10,
            right: 10,
          ),
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
                    Text(
                      _transactionDate == null
                          ? "No date chosen"
                          : DateFormat.yMd().format(_transactionDate!),
                    ),
                    AdaptiveFlatButton(
                        text: "Choose date", handler: _showDatePicker),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _saveData,
                child: Text(
                  'Add Transaction',
                  style: TextStyle(
                    color: themeOfContext.textTheme.button!.color,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
