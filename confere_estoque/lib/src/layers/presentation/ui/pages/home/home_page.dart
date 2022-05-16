import 'package:confere_estoque/src/layers/presentation/ui/pages/home/widgets/app_bar_widget.dart';
import 'package:confere_estoque/src/layers/presentation/ui/pages/home/widgets/product_result_widget.dart';
import 'package:confere_estoque/src/layers/presentation/ui/pages/home/widgets/radiogroup_cf_widget.dart';
import 'package:confere_estoque/src/utils/constants.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.camera_alt_rounded),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  TextField(
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
                  const ProductResultWidget(),
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
