import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transaction.dart';

class Chart extends StatelessWidget {
  const Chart(this.transactions, {Key? key}) : super(key: key);

  final List<Transaction> transactions;

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = 0.0;

      for (var i = 0; i < transactions.length; i++) {
        bool sameDay = transactions[i].date.day == weekDay.day;
        bool sameMonth = transactions[i].date.month == weekDay.month;
        bool sameYear = transactions[i].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += transactions[i].value;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay)[0],
        'value': totalSum,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Row(
        children: groupedTransactions
            .map((tr) => Text('${tr['day']}: ${tr['value']}}'))
            .toList(),
      ),
    );
  }
}
