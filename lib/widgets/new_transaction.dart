
import 'package:flutter/material.dart';
import '../widgets/adaptive_elevatedButton.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction) {
    print("constructor new transaction Widget");
  }

  @override
  State<NewTransaction> createState() {
    print("create state newTransaction Widget");
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  _NewTransactionState() {
    print("construction new transaction state");
  }
  @override
  void initState() {
    print("initState");
    super.initState();
  }

  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
        print("didUpdateWidget");

    super.didUpdateWidget(oldWidget);
  }
  
  @override
  void dispose() {
    print("disposeWidget");
    super.dispose();
  }


  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addNewTransaction(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
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
            left: 10,
            right: 10,
            top: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),

                // onChanged: (value) {
                //   titleInput = value;
                // },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
                // onChanged: (value) {
                //   amountInput = value;
                // },
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Date Chosen'
                            : 'Picked Date : ${DateFormat.yMd().format(_selectedDate)}',
                      ),
                    ),
                    AdaptiveElevatedButton("Choose Date", _presentDatePicker)
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  onPrimary: Theme.of(context).primaryColor,
                ),
                onPressed: _submitData,
                child: Text(
                  "Add Transaction",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.button.color,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
