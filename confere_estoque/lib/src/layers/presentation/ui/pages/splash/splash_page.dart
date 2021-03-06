// ignore_for_file: use_build_context_synchronously

import 'package:confere_estoque/src/layers/presentation/ui/pages/config/config_page.dart';
import 'package:confere_estoque/src/layers/presentation/ui/pages/home/home_page.dart';
import 'package:confere_estoque/src/layers/presentation/ui/pages/login/login_page.dart';
import 'package:confere_estoque/src/layers/services/shared_service.dart';
import 'package:confere_estoque/src/theme/app_theme.dart';
import 'package:confere_estoque/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<void> inicializar() async {
    await Future.delayed(const Duration(seconds: 2));

    if (GetIt.I.get<SharedService>().readIpServer().trim().isEmpty) {
      await Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
            child: const ConfigPage(),
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
            alignment: Alignment.center,
          ),
          (route) => false);
      return;
    }

    if (GetIt.I.get<SharedService>().readLogado()) {
      await Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
            child: const HomePage(),
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
            alignment: Alignment.center,
          ),
          (route) => false);
      return;
    } else {
      await Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
            child: const LoginPage(),
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
            alignment: Alignment.center,
          ),
          (route) => false);
      return;
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
      body: SizedBox(
        width: context.screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset('assets/images/splash.json',
                width: context.screenWidth * .5),
            Text(
              'Confere Estoque',
              style: AppTheme.textStyles.titleSplash,
            ),
          ],
        ),
      ),
    );
  }
}
