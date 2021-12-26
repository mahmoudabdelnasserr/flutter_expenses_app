import 'package:expenses_app/models/transaction.dart';
import 'package:expenses_app/widgets/chart_bar.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  final List<Transaction> rescentTransactions;
  Chart(this.rescentTransactions);
  List<Map<String, Object>> get groupedTransactionValues{
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index),);
      var totalSum = 0.0;
      for (var i = 0; i < rescentTransactions.length; i++)
        if (rescentTransactions[i].date.day == weekDay.day &&
            rescentTransactions[i].date.month == weekDay.month
        && rescentTransactions[i].date.year == weekDay.year){
          totalSum += rescentTransactions[i].amount;
        }
      print(DateFormat.E().format(weekDay));
      print(totalSum);
      return {'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum};
    }).reversed.toList();
  }
  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item){
      return sum + (item['amount']as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(elevation:6,
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValues.map((data) {
            return Flexible(
                fit: FlexFit.tight,
                child: ChartBar((data['day'] as String), (data['amount']as double),totalSpending == 0.0 ? 0.0 : (data['amount'] as double) / totalSpending,));
    }).toList()

          ,),
        ),
    );
  }
}
