import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double) addTransaction;

  const TransactionForm(this.addTransaction, {Key? key}) : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();

  final valueController = TextEditingController();

  void _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }

    widget.addTransaction(title, value);
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
                children: [
                  const Text("Nunhuma data selecionada!"),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "Selecionar Data",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).primaryColor),
                    ),
                    child: Text(
                      "Nova Transação",
                      style: TextStyle(
                          color: Theme.of(context).textTheme.button!.color),
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
