import 'dart:async';

import 'package:confere_estoque/app_widget.dart';
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

      runApp(AppWidget());
    },
    (error, st) => print(error),
  );
}
