import 'package:cortexia/core/routing/app_router.dart';
import 'package:flutter/material.dart';

import 'core/routing/routes.dart';
import 'core/themes/text_themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme, // ربط الثيم اللي عملناه
      initialRoute: Routes.splashScreen,
      onGenerateRoute: AppRouter().generateRoute,
    );
  }
}
