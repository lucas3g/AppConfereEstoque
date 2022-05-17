import 'package:confere_estoque/src/layers/presentation/blocs/product_bloc/events/product_events.dart';
import 'package:confere_estoque/src/layers/presentation/blocs/product_bloc/product_bloc.dart';
import 'package:confere_estoque/src/layers/presentation/blocs/product_bloc/states/product_states.dart';
import 'package:confere_estoque/src/layers/presentation/ui/pages/home/widgets/app_bar_widget.dart';
import 'package:confere_estoque/src/layers/presentation/ui/pages/home/widgets/product_result_widget.dart';
import 'package:confere_estoque/src/layers/presentation/ui/pages/home/widgets/radiogroup_cf_widget.dart';
import 'package:confere_estoque/src/theme/app_theme.dart';
import 'package:confere_estoque/src/utils/constants.dart';
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
  final codigoController = TextEditingController();
  FocusNode codigo = FocusNode();
  FocusNode qtd = FocusNode();

  @override
  void initState() {
    super.initState();

    codigo.addListener(() {
      if (!codigo.hasFocus) {
        blocProduct.add(
          ProductGetEvent(codigo: '1', ccusto: 101),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(context: context),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: SingleChildScrollView(
          child: SizedBox(
            height: context.screenHeight * 0.8,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: codigoController,
                          focusNode: codigo,
                          onEditingComplete: () {
                            blocProduct.add(
                              ProductGetEvent(codigo: '1', ccusto: 101),
                            );
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
                      const SizedBox(width: 10),
                      SizedBox(
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () async {
                            codigoController.text =
                                await FlutterBarcodeScanner.scanBarcode(
                                    '#ffcf1f36',
                                    'Fechar',
                                    false,
                                    ScanMode.BARCODE);
                            blocProduct.add(
                              ProductGetEvent(codigo: '1', ccusto: 101),
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
                  const SizedBox(height: 15),
                  TextField(
                    focusNode: qtd,
                    decoration: InputDecoration(
                      label: const Text('Quantidade'),
                      hintText: 'Digite quantidade',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const RadioGroupCFWidget(),
                  const SizedBox(height: 15),
                  BlocBuilder<ProductBloc, ProductStates>(
                      bloc: blocProduct,
                      builder: (context, state) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            AnimatedOpacity(
                              opacity: state is ProductLoadingState ? 1 : 0,
                              duration: const Duration(milliseconds: 500),
                              child: SpinKitWave(
                                color: AppTheme.colors.primary,
                                size: 50.0,
                              ),
                            ),
                            AnimatedOpacity(
                              opacity: state is ProductSuccessState ? 1 : 0,
                              duration: const Duration(milliseconds: 500),
                              child: const ProductResultWidget(),
                            ),
                            AnimatedOpacity(
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
                          ],
                        );
                      }),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.check_circle_rounded),
                                SizedBox(width: 10),
                                Text('Atualizar estoque'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
