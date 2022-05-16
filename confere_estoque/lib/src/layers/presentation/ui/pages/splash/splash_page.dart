import 'package:confere_estoque/src/theme/app_theme.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<void> inicializar() async {
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pushReplacementNamed(context, '/home');
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
