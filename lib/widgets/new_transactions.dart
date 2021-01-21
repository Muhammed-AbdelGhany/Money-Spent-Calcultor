import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class NewTransactions extends StatefulWidget {
  final Function adTx;
  NewTransactions(this.adTx);

  @override
  _NewTransactionsState createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final titleControler = new TextEditingController();
  final amountController = new TextEditingController();
  DateTime choosenDate;

  void submitData() {
    final titleText = titleControler.text;
    final amountNumber = double.parse(amountController.text);

    if (titleText.isEmpty || amountNumber.isNegative || choosenDate == null) {
      return;
    }
    widget.adTx(titleText, amountNumber, choosenDate);
    Navigator.pop(context);
  }

  void presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        choosenDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.amber[100],
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleControler,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(choosenDate == null
                        ? "No Date Enterd"
                        : "Date : ${DateFormat.yMd().format(choosenDate)}"),
                  ),
                  FlatButton(
                    onPressed: presentDatePicker,
                    child: Text(
                      'Choose Date',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            FlatButton(
              child: Text('Make transaction'),
              textColor: Theme.of(context).textTheme.button.color,
              color: Theme.of(context).primaryColor,
              onPressed: submitData,
            ),
          ],
        ),
      ),
    );
  }
}
