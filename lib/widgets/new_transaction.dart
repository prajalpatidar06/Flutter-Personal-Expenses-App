import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function _addNewTransaction;
  NewTransaction(this._addNewTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  void _submitData() {
    if (_titleController.text.isEmpty ||
        _amountController.text.isEmpty ||
        _selectedDate == null) return;
    widget._addNewTransaction(_titleController.text,
        double.parse(_amountController.text), _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
                // onChanged: (value) => titleInput = value,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
                // onChanged: (value) => amountInput = value,
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                        child: Text(_selectedDate == null
                            ? 'No Date Chosen!'
                            : DateFormat.yMMMd()
                                .format(_selectedDate as DateTime))),
                    TextButton(
                      onPressed: _presentDatePicker,
                      child: Text('Choose Date'),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.purple),
                  onPressed: () => _submitData(),
                  child: Text(
                    'Add Transaction',
                    style: TextStyle(fontWeight: FontWeight.bold),
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
