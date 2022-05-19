import 'package:flutter/material.dart';

class ModalProductsWidget extends StatefulWidget {
  const ModalProductsWidget({Key? key}) : super(key: key);

  @override
  State<ModalProductsWidget> createState() => _ModalProductsWidgetState();
}

class _ModalProductsWidgetState extends State<ModalProductsWidget> {
  @override
  Widget build(BuildContext context) {
    return const Text('Vai abrir o modal');
  }
}
