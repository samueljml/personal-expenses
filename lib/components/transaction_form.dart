import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  final titleController = TextEditingController();
  final valueController = TextEditingController();
  final void Function(String, double) addTransaction;

  TransactionForm(this.addTransaction, {Key? key}) : super(key: key);

  void _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }

    addTransaction(title, value);
  }

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
                onSubmitted: (_) => _submitForm(),
                decoration: const InputDecoration(
                  labelText: "Título",
                ),
              ),
              TextField(
                controller: valueController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitForm(),
                decoration: const InputDecoration(labelText: "valor (R\$)"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: const Text(
                      "Nova Transação",
                      style: TextStyle(color: Colors.purple),
                    ),
                    onPressed: _submitForm,
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
