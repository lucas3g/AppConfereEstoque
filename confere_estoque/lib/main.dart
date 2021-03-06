// ignore_for_file: avoid_print

import 'dart:async';

import 'package:confere_estoque/app_widget.dart';
import 'package:confere_estoque/src/core/inject.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await initializeDateFormatting();

      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, // status bar color
        ),
      );

      // SystemChrome.setPreferredOrientations([
      //   DeviceOrientation.portraitDown,
      //   DeviceOrientation.portraitUp,
      // ]);

      Inject.init();

      runApp(const AppWidget());
    },
    (error, st) => print(error),
  );
}
