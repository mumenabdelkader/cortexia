
// Dependency Injection
import 'package:flutter/material.dart';
import '../../welcome_screens.dart';
import 'routes.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(
          builder:
              (_) => WelcomeScreen()
        );

      default:
        return null;
    }
  }
}
