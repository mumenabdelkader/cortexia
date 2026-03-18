
// Dependency Injection
import 'package:flutter/material.dart';
import '../../welcome_screens.dart';
import 'package:cortexia/features/authentication/presentation/ui/forgot_password_screen.dart';
import '../../features/patient/presentation/ui/clinical_notes_screen.dart';
import '../../features/patient/presentation/ui/fluid_balance_screen.dart';
import '../../features/patient/presentation/ui/lab_results_screen.dart';
import '../../features/patient/presentation/ui/clinical_alerts_screen.dart';
import '../../features/patient/presentation/ui/main_navigation_screen.dart';
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
      case Routes.forgotPasswordScreen:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordScreen(),
        );
      case Routes.clinicalNotesScreen:
        return MaterialPageRoute(
          builder: (_) => const ClinicalNotesScreen(),
        );
      case Routes.fluidBalanceScreen:
        return MaterialPageRoute(
          builder: (_) => const FluidBalanceScreen(),
        );
      case Routes.labResultsScreen:
        return MaterialPageRoute(
          builder: (_) => const LabResultsScreen(),
        );
      case Routes.clinicalAlertsScreen:
        return MaterialPageRoute(
          builder: (_) => const ClinicalAlertsScreen(),
        );
      case Routes.mainNavigationScreen:
        return MaterialPageRoute(
          builder: (_) => const MainNavigationScreen(),
        );

      default:
        return null;
    }
  }
}
