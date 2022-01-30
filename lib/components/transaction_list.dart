import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  final void Function(String) onRemove;

  const TransactionList(this.transactions, {required this.onRemove, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        child: transactions.isEmpty
            ? Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Nenhuma Transação Cadastrada",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 200,
                    child: Image.asset(
                      "assets/images/waiting.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              )
            : ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (ctx, index) {
                  final tr = transactions[index];
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 5,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: FittedBox(
                            child: Text('R\$${tr.value}'),
                          ),
                        ),
                      ),
                      title: Text(
                        tr.title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(DateFormat('d MMM y').format(tr.date)),
                      trailing: TextButton(
                        onPressed: () => onRemove(tr.id),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  );
                },
              ));
  }
}
