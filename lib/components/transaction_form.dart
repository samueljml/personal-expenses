import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  final titleController = TextEditingController();
  final valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Título",
                ),
              ),
              TextField(
                controller: valueController,
                decoration: const InputDecoration(labelText: "valor (R\$)"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Nova Transação",
                      style: TextStyle(color: Colors.purple),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
