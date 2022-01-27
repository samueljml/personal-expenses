import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double value;
  final double percentage;
  final String lable;

  const ChartBar(
      {Key? key,
      required this.value,
      required this.lable,
      required this.percentage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('R\$${value.toStringAsFixed(2)}'),
        const SizedBox(height: 5),
        Container(
          height: 60,
          width: 10,
          child: null,
          color: Colors.black,
        ),
        const SizedBox(height: 5),
        Text(lable),
      ],
    );
  }
}
