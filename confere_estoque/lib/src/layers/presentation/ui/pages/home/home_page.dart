import 'dart:async';

import 'package:confere_estoque/src/layers/domain/entities/product_entity.dart';
import 'package:confere_estoque/src/layers/presentation/blocs/ccustos_bloc/ccustos_bloc.dart';
import 'package:confere_estoque/src/layers/presentation/blocs/estoque_bloc/estoque_bloc.dart';
import 'package:confere_estoque/src/layers/presentation/blocs/estoque_bloc/events/estoque_events.dart';
import 'package:confere_estoque/src/layers/presentation/blocs/estoque_bloc/states/estoque_states.dart';
import 'package:confere_estoque/src/layers/presentation/blocs/product_bloc/events/product_events.dart';
import 'package:confere_estoque/src/layers/presentation/blocs/product_bloc/product_bloc.dart';
import 'package:confere_estoque/src/layers/presentation/blocs/product_bloc/states/product_states.dart';
import 'package:confere_estoque/src/layers/presentation/ui/pages/home/widgets/app_bar_widget.dart';
import 'package:confere_estoque/src/layers/presentation/ui/pages/home/widgets/product_result_widget.dart';
import 'package:confere_estoque/src/layers/presentation/ui/pages/home/widgets/radiogroup_cf_widget.dart';
import 'package:confere_estoque/src/theme/app_theme.dart';
import 'package:confere_estoque/src/utils/constants.dart';
import 'package:confere_estoque/src/utils/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final blocProduct = GetIt.I.get<ProductBloc>();
  final blocCCusto = GetIt.I.get<CCustosBloc>();
  final blocEstoque = GetIt.I.get<EstoqueBloc>();
  final codigoController = TextEditingController();
  final descController = TextEditingController();
  final qtdController = MoneyMaskedTextController();
  FocusNode codigo = FocusNode();
  FocusNode desc = FocusNode();
  FocusNode qtd = FocusNode();
  GlobalKey<FormState> keyCod = GlobalKey<FormState>();
  GlobalKey<FormState> keyDesc = GlobalKey<FormState>();
  GlobalKey<FormState> keyQtd = GlobalKey<FormState>();

  late StreamSubscription subEstoque;

  @override
  void initState() {
    super.initState();

    codigo.addListener(() {
      if (!codigo.hasFocus) {
        if (!keyCod.currentState!.validate()) {
          return;
        }
        blocProduct.add(
          ProductGetEvent(
            codigo: codigoController.text.trim(),
            ccusto: blocCCusto.ccusto,
          ),
        );
      }
    });

    subEstoque = blocEstoque.stream.listen((state) {
      if (state is EstoqueSuccessState) {
        const snackBar = SnackBar(
          content: Text('Successo. Estoque atualizado.'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        codigoController.clear();
        qtdController.text = '0.00';
      }
      if (state is EstoqueErrorState) {
        late SnackBar snackBar = SnackBar(
          content: Text(
              'Opss... Erro ao tentar atualizar o estoque. \n ${state.message}'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  @override
  void dispose() {
    subEstoque.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(context: context),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
        child: SingleChildScrollView(
          child: SizedBox(
            height: context.screenHeight * .79,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Form(
                          key: keyCod,
                          child: TextFormField(
                            validator: (value) {
                              if (descController.text.trim().isEmpty &&
                                  (value == null || value.isEmpty)) {
                                return 'Código não pode ser vazio.';
                              }
                              return null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: codigoController,
                            focusNode: codigo,
                            onEditingComplete: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                            decoration: InputDecoration(
                              label: const Text('Cód. Produto'),
                              hintText: 'Digite o código do produto',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        height: 60,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 2,
                            alignment: Alignment.center,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () async {
                            codigoController.text =
                                await FlutterBarcodeScanner.scanBarcode(
                                    '#ffcf1f36',
                                    'Fechar',
                                    false,
                                    ScanMode.BARCODE);
                            blocProduct.add(
                              ProductGetEvent(
                                codigo: codigoController.text.trim(),
                                ccusto: blocCCusto.ccusto,
                              ),
                            );
                            qtd.requestFocus();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset(
                                'assets/images/barcode.json',
                                repeat: false,
                                width: 50,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Form(
                  key: keyDesc,
                  child: TextFormField(
                    validator: (value) {
                      if (codigoController.text.trim().isEmpty &&
                          (value == null || value.isEmpty)) {
                        return 'Descrição não pode ser vazio.';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: descController,
                    focusNode: desc,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    decoration: InputDecoration(
                      label: const Text('Descrição Produto'),
                      hintText: 'Digite a descrição do produto',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    inputFormatters: [UpperCaseTextFormatter()],
                  ),
                ),
                const SizedBox(height: 15),
                Form(
                  key: keyQtd,
                  child: TextFormField(
                    controller: qtdController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Quantidade não pode ser vazia.';
                      }
                      if (value.contains('-')) {
                        return 'Quantidade não pode ser negativo.';
                      }
                      if (value.contains('0,00')) {
                        return 'Quantidade não pode ser zero(0).';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    focusNode: qtd,
                    decoration: InputDecoration(
                      label: const Text('Quantidade'),
                      hintText: 'Digite uma quantidade',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(height: 15),
                const RadioGroupCFWidget(),
                const SizedBox(height: 15),
                SizedBox(
                  child: BlocBuilder<ProductBloc, ProductStates>(
                      bloc: blocProduct,
                      builder: (context, state) {
                        return Stack(
                          alignment: state is ProductLoadingState ||
                                  state is ProductErrorState
                              ? Alignment.center
                              : Alignment.topCenter,
                          children: [
                            Visibility(
                              visible: state is ProductLoadingState,
                              child: AnimatedOpacity(
                                opacity: state is ProductLoadingState ? 1 : 0,
                                duration: Duration(
                                    milliseconds:
                                        state is ProductSuccessState ? 0 : 500),
                                child: SpinKitWave(
                                  color: AppTheme.colors.primary,
                                  size: 50.0,
                                ),
                              ),
                            ),
                            Visibility(
                              visible: state is ProductSuccessState,
                              child: AnimatedOpacity(
                                opacity: state is ProductSuccessState ? 1 : 0,
                                duration: Duration(
                                    milliseconds:
                                        state is ProductSuccessState ? 500 : 0),
                                child: ProductResultWidget(
                                  productEntity: state is ProductSuccessState
                                      ? state.productEntity
                                      : ProductEntity(
                                          ID: 'ID',
                                          DESCRICAO: 'DESCRICAO',
                                          SUCINTO: 'SUCINTO',
                                          UNIDADE: 'UNIDADE',
                                          SUBGRUPO: 'SUBGRUPO',
                                          VENDA: 0,
                                          SERVICO: 'SERVICO',
                                          ATIVO: 'ATIVO',
                                          CUSTO_ULTIMO: 0,
                                          DESCONTO_MAX: 0,
                                          EST_FISICO: 0,
                                          EST_ATUAL: 0,
                                        ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: state is ProductErrorState,
                              child: AnimatedOpacity(
                                opacity: state is ProductErrorState ? 1 : 0,
                                duration: const Duration(milliseconds: 500),
                                child: SizedBox(
                                  height: context.screenHeight * 0.38,
                                  child: SingleChildScrollView(
                                    child: state is ProductErrorState
                                        ? Text(state.message)
                                        : const Text(''),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    height: 50,
                    child: BlocBuilder<EstoqueBloc, EstoqueStates>(
                        bloc: blocEstoque,
                        builder: (context, stateEstoque) {
                          return BlocBuilder<ProductBloc, ProductStates>(
                              bloc: blocProduct,
                              builder: (context, stateProduto) {
                                return SizedBox(
                                  width: context.screenWidth,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 2,
                                      alignment: Alignment.center,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    onPressed: stateEstoque
                                            is! EstoqueLoadingState
                                        ? () {
                                            if ((!keyCod.currentState!
                                                        .validate() ||
                                                    !keyDesc.currentState!
                                                        .validate()) ||
                                                !keyQtd.currentState!
                                                    .validate()) {
                                              return;
                                            }
                                            if ((stateProduto
                                                        is ProductSuccessState &&
                                                    stateProduto
                                                            .productEntity.DESCRICAO ==
                                                        'Produto não encontrado') ||
                                                (stateProduto
                                                        is ProductErrorState ||
                                                    codigoController.text
                                                        .trim()
                                                        .isEmpty ||
                                                    qtdController.text
                                                        .trim()
                                                        .isEmpty)) {
                                              const snackBar = SnackBar(
                                                content: Text(
                                                    'Não é possível atualizar o estoque. Verifique a mercadoria.'),
                                              );

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                              return;
                                            }

                                            blocEstoque.add(
                                              UpdateEstoqueEvent(
                                                codigo: codigoController.text,
                                                ccusto: blocCCusto.ccusto,
                                                quantidade: qtdController.text,
                                                tipoEstoque:
                                                    blocEstoque.estoques.name ==
                                                            'contabil'
                                                        ? 'C'
                                                        : 'F',
                                              ),
                                            );
                                          }
                                        : null,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        stateEstoque is! EstoqueLoadingState
                                            ? const Icon(
                                                Icons.check_circle_rounded)
                                            : const Text(''),
                                        const SizedBox(width: 10),
                                        stateEstoque is EstoqueLoadingState
                                            ? const Center(
                                                child: SizedBox(
                                                  height: 20,
                                                  width: 20,
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              )
                                            : const Text('Atualizar estoque'),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
