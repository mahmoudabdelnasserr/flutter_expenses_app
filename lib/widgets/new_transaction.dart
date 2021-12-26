import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _selectedDate;

  void submit(){
      if (amountController.text.isEmpty){
        return;
      }
      final enteredTitle = titleController.text;
      final amountEntered = double.parse(amountController.text);

      if (enteredTitle.isEmpty || amountEntered <= 0 || _selectedDate == null ){
        return;
      }

      widget.addTx(
        enteredTitle,
        amountEntered,
        _selectedDate
      );
      Navigator.of(context).pop();
  }
      void datePicker() {
        showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2021), lastDate: DateTime.now(),
        ).then((pickedDate){
          if (pickedDate == null){
            return;
          }
          _selectedDate = pickedDate;
          setState(() {

          });

        });
        print('...');
      }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submit,
              // onChanged: (val) {
              //   titleInput = val;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submit,
              // onChanged: (val) => amountInput = val,
            ),
            Container(
              height: 70,
              child: Row(children: <Widget> [
                Expanded(child: Text(_selectedDate == null ? 'No date chosen' : 'picked date ${DateFormat.yMd().format(_selectedDate!)}')),
                FlatButton(

                  textColor: Theme.of(context).primaryColor,
                  child: Container(
                    color: Colors.purple[50],
                    child: Text(
                    'Choose date',style: TextStyle(fontWeight: FontWeight.bold),
                ),
                  ),
                onPressed: datePicker,)
              ],),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
              color: Theme.of(context).primaryColor,
              child: FlatButton(
                color: Theme.of(context).primaryColor,
                child: Text('Add Transaction'),
                textColor: Theme.of(context).textTheme.button!.color,
                onPressed: submit,

              ),
            ),
          ],
        ),
      ),
    );
  }
}
