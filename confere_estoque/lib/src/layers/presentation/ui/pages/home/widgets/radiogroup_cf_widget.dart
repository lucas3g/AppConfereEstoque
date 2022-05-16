import 'package:flutter/material.dart';

enum Estoques { fisico, contabil }

class RadioGroupCFWidget extends StatefulWidget {
  const RadioGroupCFWidget({Key? key}) : super(key: key);

  @override
  State<RadioGroupCFWidget> createState() => _RadioGroupCFWidgetState();
}

class _RadioGroupCFWidgetState extends State<RadioGroupCFWidget> {
  Estoques? estoques = Estoques.contabil;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: RadioListTile<Estoques>(
              title: const Text('Contabil'),
              value: Estoques.contabil,
              groupValue: estoques,
              onChanged: (Estoques? value) {
                setState(() {
                  estoques = value;
                });
              }),
        ),
        Expanded(
          child: RadioListTile<Estoques>(
              title: const Text('Fisico'),
              value: Estoques.fisico,
              groupValue: estoques,
              onChanged: (Estoques? value) {
                setState(() {
                  estoques = value;
                });
              }),
        ),
      ],
    );
  }
}
