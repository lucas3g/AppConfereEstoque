// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:confere_estoque/src/utils/my_snackbar.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final qtdController = TextEditingController();
  FocusNode codigo = FocusNode();
  FocusNode desc = FocusNode();
  FocusNode qtd = FocusNode();
  GlobalKey<FormState> keyCod = GlobalKey<FormState>();
  GlobalKey<FormState> keyDesc = GlobalKey<FormState>();
  GlobalKey<FormState> keyQtd = GlobalKey<FormState>();

  late StreamSubscription subEstoque;
  late StreamSubscription subProd;

  late List<ProductEntity> productEntitySelected = [];

  late bool checkCamera = false;

  @override
  void initState() {
    super.initState();

    subEstoque = blocEstoque.stream.listen((state) async {
      if (state is EstoqueSuccessState) {
        MySnackBar(
          message: 'Successo. Estoque inserido.',
        );
        codigoController.clear();
        descController.clear();
        qtdController.text = '';
        if (checkCamera) {
          await openCamera();
        }
      }

      if (state is EstoqueGetSuccessState) {
        productEntitySelected[0].EST_ATUAL = 0.0;
        productEntitySelected[0].EST_FISICO = 0.0;
        productEntitySelected[0].EST_CONTADO =
            double.parse(state.estoqueEntity.QTD_NOVO.toString()).toDouble();

        setState(() {});
        Navigator.pop(context);
      }

      if (state is EstoqueErrorState) {
        MySnackBar(
          message:
              'Opss... Erro ao tentar atualizar o estoque. \n ${state.message.replaceAll('Exception:', '')}',
        );
      }
    });

    subProd = blocProduct.stream.listen((state) async {
      if (state is ProductSuccessState && state.productEntity.length > 1) {
        await abreModal(products: state.productEntity);
      } else if (state is ProductSuccessState) {
        productEntitySelected = state.productEntity;
      }
    });
  }

  @override
  void dispose() {
    subEstoque.cancel();
    subProd.cancel();

    super.dispose();
  }

  Future<void> abreModal({required List<ProductEntity> products}) async {
    late String codProd = '';
    await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Selecione um produto',
                style: AppTheme.textStyles.textoSairApp,
              ),
              const Divider(),
              ...products
                  .map(
                    (produto) => BlocBuilder<EstoqueBloc, EstoqueStates>(
                      bloc: blocEstoque,
                      builder: (context, state) {
                        return ListTile(
                          trailing: state is EstoqueGetLoadingState &&
                                  codProd == produto.ID
                              ? const SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : null,
                          leading: SizedBox(
                            width: 50,
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://cdn-cosmos.bluesoft.com.br/products/${produto.GTIN}',
                              placeholder: (context, url) => SizedBox(
                                width: 60,
                                height: 60,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: AppTheme.colors.primary,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(Icons.error,
                                      color: Colors.red, size: 30),
                                ],
                              ),
                            ),
                          ),
                          contentPadding: EdgeInsets.zero,
                          title: Text(produto.DESCRICAO),
                          subtitle: state is EstoqueGetLoadingState &&
                                  codProd == produto.ID
                              ? const Text('Buscando estoque. Aguarde...')
                              : null,
                          onTap: () async {
                            codProd = produto.ID;
                            productEntitySelected.add(produto);

                            blocEstoque.add(
                              GetEstoqueEvent(
                                codigo: produto.ID,
                                ccusto: blocCCusto.ccusto,
                              ),
                            );

                            setState(() {});
                            await Future.delayed(
                                const Duration(milliseconds: 300));
                            qtd.requestFocus();
                          },
                        );
                      },
                    ),
                  )
                  .toList(),
            ],
          ),
        );
      },
    );
  }

  Future<void> openCamera() async {
    codigoController.text = await FlutterBarcodeScanner.scanBarcode(
        '#ffcf1f36', 'Fechar', false, ScanMode.BARCODE);

    if (codigoController.text.trim() != '-1') {
      blocProduct.add(
        ProductGetEvent(
          codigo: codigoController.text.trim(),
          descricao: '',
          ccusto: blocCCusto.ccusto,
        ),
      );

      qtd.requestFocus();
    } else {
      codigoController.clear();
    }
    descController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(context: context),
      body: Padding(
        padding: EdgeInsets.only(
          left: context.screenWidth * .03,
          right: context.screenWidth * .03,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          height: context.screenHeight * .75,
          child: SingleChildScrollView(
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
                            onTap: descController.clear,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: codigoController,
                            focusNode: codigo,
                            onEditingComplete: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                            decoration: InputDecoration(
                              label: const Text('C??d. Produto'),
                              hintText: 'Digite o c??digo do produto',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        height: context.screenHeight * .07,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 2,
                            alignment: Alignment.center,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () async {
                            await openCamera();
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
                SizedBox(height: context.screenHeight * .015),
                Form(
                  key: keyDesc,
                  child: TextFormField(
                    onTap: codigoController.clear,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: descController,
                    focusNode: desc,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    decoration: InputDecoration(
                      label: const Text('Descri????o Produto'),
                      hintText: 'Digite a descri????o do produto',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    inputFormatters: [UpperCaseTextFormatter()],
                  ),
                ),
                SizedBox(height: context.screenHeight * .015),
                Row(
                  children: [
                    Expanded(
                      child: BlocBuilder<ProductBloc, ProductStates>(
                          bloc: blocProduct,
                          builder: (context, state) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(0, context.screenHeight * .055),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: state is! ProductLoadingState
                                  ? () {
                                      if (codigoController.text
                                              .trim()
                                              .isEmpty &&
                                          descController.text.trim().isEmpty) {
                                        MySnackBar(
                                          message:
                                              'Informe um C??digo ou uma Descri????o para buscar os dados.',
                                        );
                                        return;
                                      }

                                      if (descController.text
                                              .trim()
                                              .isNotEmpty &&
                                          descController.text.trim().length <
                                              3) {
                                        MySnackBar(
                                          message:
                                              'Descri????o deve conter pelo menos 3 caracteres.',
                                        );
                                        return;
                                      }

                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());

                                      if (productEntitySelected.isNotEmpty) {
                                        productEntitySelected.clear();
                                        productEntitySelected = [];
                                      }

                                      blocProduct.add(
                                        ProductGetEvent(
                                          codigo: codigoController.text.trim(),
                                          descricao: descController.text
                                              .trim()
                                              .removeAcentos(),
                                          ccusto: blocCCusto.ccusto,
                                        ),
                                      );
                                    }
                                  : null,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.search_rounded),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('Buscar dados'),
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                ),
                SizedBox(height: context.screenHeight * .015),
                Form(
                  key: keyQtd,
                  child: TextFormField(
                    controller: qtdController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Quantidade n??o pode ser vazia.';
                      }
                      if (value.contains('-')) {
                        return 'Quantidade n??o pode ser negativo.';
                      }
                      if (value == '0,00') {
                        return 'Quantidade n??o pode ser zero(0).';
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
                    inputFormatters: [
                      TextInputMask(
                        mask: " ! !9+.999,99",
                        reverse: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: context.screenHeight * .005),
                const RadioGroupCFWidget(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                      activeColor: AppTheme.colors.primary,
                      value: checkCamera,
                      onChanged: (_) {
                        setState(() {
                          checkCamera = !checkCamera;
                        });
                      },
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            checkCamera = !checkCamera;
                          });
                        },
                        child: Text(
                          'Abrir camera logo apos atualizar estoque?',
                          style: AppTheme.textStyles.textoSairApp,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: context.screenHeight * .005),
                BlocBuilder<ProductBloc, ProductStates>(
                    bloc: blocProduct,
                    builder: (context, state) {
                      return Stack(
                        alignment: state is ProductLoadingState ||
                                state is ProductErrorState
                            ? Alignment.center
                            : Alignment.topCenter,
                        children: [
                          AnimatedOpacity(
                            opacity: state is ProductLoadingState ? 1 : 0,
                            duration: const Duration(milliseconds: 0),
                            child: SpinKitWave(
                              color: AppTheme.colors.primary,
                              size: 50.0,
                            ),
                          ),
                          AnimatedOpacity(
                            opacity: state is ProductSuccessState ? 1 : 0,
                            duration: Duration(
                                milliseconds:
                                    state is ProductSuccessState ? 600 : 0),
                            child: ProductResultWidget(
                              productEntity: state is ProductSuccessState &&
                                      productEntitySelected.isNotEmpty &&
                                      productEntitySelected[0].DESCRICAO !=
                                          'DESCRICAO'
                                  ? productEntitySelected[0]
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
                          AnimatedOpacity(
                            opacity: state is ProductErrorState ? 1 : 0,
                            duration: const Duration(milliseconds: 500),
                            child: state is ProductErrorState
                                ? Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(20),
                                    width: context.screenWidth,
                                    decoration: BoxDecoration(
                                      color:
                                          AppTheme.colors.primary.withAlpha(30),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      state.message
                                          .replaceAll('Exception:', ''),
                                      style: AppTheme.textStyles.titleEstoque,
                                    ),
                                  )
                                : const Text(''),
                          ),
                        ],
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: SizedBox(
        height: context.screenHeight * .065,
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
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        onPressed: stateEstoque is! EstoqueLoadingState &&
                                stateProduto is ProductSuccessState
                            ? () {
                                if ((productEntitySelected[0].DESCRICAO ==
                                        'Produto n??o encontrado') ||
                                    (stateProduto is ProductErrorState ||
                                        (productEntitySelected[0].ID ==
                                            'ID'))) {
                                  MySnackBar(
                                    message:
                                        'N??o ?? poss??vel atualizar o estoque. Verifique a mercadoria.',
                                  );
                                  return;
                                }

                                if (qtdController.text.trim() == '0,00') {
                                  MySnackBar(
                                    message: 'Quantidade n??o pode ser zero(0).',
                                  );
                                  return;
                                }

                                blocEstoque.add(
                                  UpdateEstoqueEvent(
                                    codigo: productEntitySelected[0].ID,
                                    ccusto: blocCCusto.ccusto,
                                    quantidade: qtdController.text.estoque(),
                                    qtdAntes:
                                        productEntitySelected[0].EST_CONTADO!,
                                    tipoEstoque:
                                        blocEstoque.estoques.name == 'contabil'
                                            ? 'C'
                                            : 'F',
                                  ),
                                );
                              }
                            : null,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            stateEstoque is! EstoqueLoadingState
                                ? const Icon(Icons.check_circle_rounded)
                                : const Text(''),
                            const SizedBox(width: 10),
                            stateEstoque is EstoqueLoadingState
                                ? const Center(
                                    child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(),
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
    );
  }
}
