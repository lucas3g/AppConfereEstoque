// ignore_for_file: use_build_context_synchronously

import 'package:confere_estoque/src/layers/services/shared_service.dart';
import 'package:confere_estoque/src/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<void> inicializar() async {
    await Future.delayed(const Duration(seconds: 1));
    if (GetIt.I.get<SharedService>().readLogado()) {
      await Navigator.pushReplacementNamed(context, '/home');
    } else {
      await Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  void initState() {
    super.initState();
    inicializar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Confere Estoque',
          style: AppTheme.textStyles.titleSplash,
        ),
      ),
    );
  }
}
