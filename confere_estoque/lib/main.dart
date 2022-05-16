import 'dart:async';

import 'package:confere_estoque/app_widget.dart';
import 'package:confere_estoque/src/core/inject.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, // status bar color
        ),
      );

      Inject.init();

      runApp(const AppWidget());
    },
    (error, st) => print(error),
  );
}
