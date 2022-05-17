import 'package:confere_estoque/src/layers/presentation/blocs/ccustos_bloc/ccustos_bloc.dart';
import 'package:confere_estoque/src/layers/presentation/blocs/ccustos_bloc/events/ccustos_events.dart';
import 'package:confere_estoque/src/layers/presentation/blocs/ccustos_bloc/states/ccustos_states.dart';
import 'package:confere_estoque/src/theme/app_theme.dart';
import 'package:confere_estoque/src/utils/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({Key? key}) : super(key: key);

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  final bloc = GetIt.I.get<CCustosBloc>();
  late int dropdownValue;

  @override
  void initState() {
    super.initState();

    bloc.add(CCustosGetAllEvent());
    bloc.stream.listen((state) {
      if (state is CCustosSuccessState) {
        bloc.ccusto = state.listCCustos[0].ID;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 54,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 10),
              blurRadius: 10,
              color: AppTheme.colors.primary.withOpacity(0.23)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocBuilder<CCustosBloc, CCustosStates>(
          bloc: bloc,
          builder: (_, state) => state is CCustosSuccessState
              ? DropdownButton(
                  borderRadius: BorderRadius.circular(20),
                  value: bloc.ccusto,
                  isExpanded: true,
                  icon: const Icon(
                    Icons.arrow_circle_down_sharp,
                  ),
                  iconSize: 30,
                  elevation: 8,
                  iconEnabledColor: AppTheme.colors.primary,
                  style: AppTheme.textStyles.textoSairApp,
                  underline: Container(),
                  onChanged: (int? newValue) {
                    setState(() {
                      bloc.ccusto = newValue!;
                    });
                  },
                  items: state.listCCustos.map((ccusto) {
                    return DropdownMenuItem(
                      value: ccusto.ID,
                      child: Text(ccusto.DESCRICAO),
                    );
                  }).toList(),
                )
              : const LoadingWidget(
                  size: Size(double.infinity, 30),
                  radius: 10,
                ),
        ),
      ),
    );
  }
}
