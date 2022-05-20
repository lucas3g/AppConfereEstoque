import 'package:confere_estoque/src/layers/presentation/ui/pages/config/config_page.dart';
import 'package:confere_estoque/src/layers/presentation/ui/pages/home/home_page.dart';
import 'package:confere_estoque/src/layers/presentation/ui/pages/login/login_page.dart';
import 'package:confere_estoque/src/layers/presentation/ui/pages/splash/splash_page.dart';
import 'package:confere_estoque/src/theme/app_theme.dart';
import 'package:confere_estoque/src/utils/navigation_service.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationService.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: AppTheme.colors.primary,
        appBarTheme: AppBarTheme(
          color: AppTheme.colors.primary,
          foregroundColor: Colors.white,
        ),
      ),
      title: 'Conferência de Estoque',
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashPage(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/config': (context) => const ConfigPage(),
      },
    );
  }
}
