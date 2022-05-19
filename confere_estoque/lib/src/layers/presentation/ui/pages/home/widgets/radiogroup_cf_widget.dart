import 'package:confere_estoque/src/layers/presentation/blocs/estoque_bloc/estoque_bloc.dart';
import 'package:confere_estoque/src/layers/presentation/blocs/estoque_bloc/states/estoque_states.dart';
import 'package:confere_estoque/src/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class RadioGroupCFWidget extends StatefulWidget {
  const RadioGroupCFWidget({Key? key}) : super(key: key);

  @override
  State<RadioGroupCFWidget> createState() => _RadioGroupCFWidgetState();
}

class _RadioGroupCFWidgetState extends State<RadioGroupCFWidget> {
  final blocEstoque = GetIt.I.get<EstoqueBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EstoqueBloc, EstoqueStates>(
        bloc: blocEstoque,
        builder: (context, state) {
          return Row(
            children: [
              Expanded(
                child: RadioListTile<Estoques>(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    activeColor: AppTheme.colors.primary,
                    title: const Text('Contabil'),
                    value: Estoques.contabil,
                    groupValue: blocEstoque.estoques,
                    onChanged: (Estoques? value) {
                      setState(() {
                        blocEstoque.estoques = value!;
                      });
                    }),
              ),
              const SizedBox(width: 2),
              Expanded(
                child: RadioListTile<Estoques>(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    activeColor: AppTheme.colors.primary,
                    title: const Text('Físico'),
                    value: Estoques.fisico,
                    groupValue: blocEstoque.estoques,
                    onChanged: (Estoques? value) {
                      setState(() {
                        blocEstoque.estoques = value!;
                      });
                    }),
              ),
            ],
          );
        });
  }
}
