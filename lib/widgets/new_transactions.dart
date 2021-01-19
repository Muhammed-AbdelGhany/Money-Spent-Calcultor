import 'package:flutter/material.dart';

class NewTransactions extends StatefulWidget {
  final Function adTx;
  NewTransactions(this.adTx);

  @override
  _NewTransactionsState createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final titleControler = new TextEditingController();
  final amountController = new TextEditingController();

  void submitData() {
    final titleText = titleControler.text;
    final amountNumber = double.parse(amountController.text);

    if (titleText.isEmpty || amountNumber.isNegative) {
      return;
    }
    widget.adTx(titleText, amountNumber);
    Navigator.pop(context);
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
            FlatButton(
              child: Text('Make transaction'),
              textColor: Colors.purple,
              onPressed: submitData,
            ),
          ],
        ),
      ),
    );
  }
}
