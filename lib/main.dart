import 'dart:math';

import 'package:flutter/material.dart';
import 'package:personal_expenses/components/chart.dart';
import 'package:personal_expenses/models/transaction.dart';

import 'components/transaction_form.dart';
import 'components/transaction_list.dart';

main() => runApp(const PersonalExpensesApp());

class PersonalExpensesApp extends StatelessWidget {
  const PersonalExpensesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        colorScheme:
            Theme.of(context).colorScheme.copyWith(secondary: Colors.amber),
        fontFamily: "Quicksand",
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: const TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
              button: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
        appBarTheme: const AppBarTheme(
          toolbarTextStyle: TextStyle(
              fontFamily: "OpenSans",
              fontSize: 20,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];
  bool _showChart = false;

  List<Transaction> get recentTransactions => _transactions
      .where((transaction) => transaction.date
          .isAfter(DateTime.now().subtract(const Duration(days: 7))))
      .toList();

  AppBar get appBar => AppBar(
        title: Text(
          "Despesas Pessoais",
          style:
              TextStyle(fontSize: 20 * MediaQuery.of(context).textScaleFactor),
        ),
        actions: [
          IconButton(
              onPressed: () => _openTransactionFormModal(context),
              icon: const Icon(Icons.add))
        ],
      );

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: date);

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final availableHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        appBar.preferredSize.height;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Exibir Gráfico"),
                Switch(
                    value: _showChart,
                    onChanged: (isShowing) {
                      setState(() {
                        _showChart = isShowing;
                      });
                    }),
              ],
            ),
            _showChart
                ? SizedBox(
                    height: availableHeight * 0.3,
                    child: Chart(recentTransactions),
                  )
                : SizedBox(
                    height: availableHeight * 0.7,
                    child: TransactionList(
                      _transactions,
                      onRemove: _removeTransaction,
                    ),
                  )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTransactionFormModal(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
