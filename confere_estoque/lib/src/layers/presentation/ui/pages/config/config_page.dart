// ignore_for_file: use_build_context_synchronously

import 'package:confere_estoque/src/layers/presentation/ui/pages/login/login_page.dart';
import 'package:confere_estoque/src/layers/presentation/ui/pages/login/widgets/my_input_widget.dart';
import 'package:confere_estoque/src/layers/services/shared_service.dart';
import 'package:confere_estoque/src/theme/app_theme.dart';
import 'package:confere_estoque/src/utils/my_snackbar.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:page_transition/page_transition.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({Key? key}) : super(key: key);

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  final ipController = TextEditingController();
  final portaController = TextEditingController();
  FocusNode ip = FocusNode();
  FocusNode porta = FocusNode();
  GlobalKey<FormState> keyIp = GlobalKey<FormState>();
  GlobalKey<FormState> keyPorta = GlobalKey<FormState>();

  final controllerIp = GetIt.I.get<SharedService>();

  @override
  void initState() {
    super.initState();

    if (controllerIp.readIpServer().isNotEmpty) {
      ipController.text = controllerIp
          .readIpServer()
          .substring(0, controllerIp.readIpServer().indexOf(':'));
      portaController.text = controllerIp.readPortServer();
    }

    if (portaController.text.isEmpty) {
      portaController.text = '9000';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Configuração do Servidor',
          style: AppTheme.textStyles.titleAppBar,
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: MyInputWidget(
                    focusNode: ip,
                    hintText: 'Digite o IP do Servidor',
                    label: 'IP do Servidor',
                    onChanged: (value) {},
                    textEditingController: ipController,
                    keyboardType: TextInputType.number,
                    formKey: keyIp,
                    inputFormaters: [
                      TextInputMask(mask: '999.999.999.999'),
                    ],
                    maxLength: 15,
                    onFieldSubmitted: (value) {
                      porta.requestFocus();
                    },
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: MyInputWidget(
                    focusNode: porta,
                    hintText: 'Porta',
                    label: 'Porta',
                    onChanged: (value) {},
                    textEditingController: portaController,
                    keyboardType: TextInputType.number,
                    formKey: keyPorta,
                    maxLength: 4,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () async {
                if (await controllerIp.setIPServer(
                        ip:
                            '${ipController.text.trim()}:${portaController.text.trim()}') &&
                    await controllerIp.setPortServer(
                        port: portaController.text.trim())) {
                  MySnackBar(
                    message: 'IP do servidor salvo com sucesso',
                  );

                  await Future.delayed(const Duration(milliseconds: 300));

                  await Navigator.pushAndRemoveUntil(
                      context,
                      PageTransition(
                        child: const LoginPage(),
                        type: PageTransitionType.rightToLeftWithFade,
                        duration: const Duration(milliseconds: 500),
                        reverseDuration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        alignment: Alignment.center,
                      ),
                      (route) => false);
                }
              },
              child: const Text(
                'Salvar Configurações',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
