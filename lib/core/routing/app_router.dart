// Dependency Injection
import 'package:cortexia/features/patient/presentation/ui/clinical_alerts_screen.dart';
import 'package:flutter/material.dart';
import '../../welcome_screens.dart';
import 'package:cortexia/features/authentication/presentation/ui/forgot_password_screen.dart';
import 'package:cortexia/features/authentication/presentation/ui/reset_password_screen.dart';
import '../../features/patient/presentation/ui/clinical_notes_screen.dart';
import '../../features/patient/presentation/ui/fluid_balance_screen.dart';
import '../../features/patient/presentation/ui/lab_results_screen.dart';
import '../../features/patient/presentation/ui/main_navigation_screen.dart';
import '../../features/patient/presentation/ui/medications_screen.dart';
import '../../features/patient/presentation/ui/imaging_screen.dart';
import '../../features/patient/presentation/ui/medical_history_screen.dart';
import 'routes.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    final admissionId = (arguments is Map ? arguments['admissionId'] : null) as String? ?? '';
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.medicalHistoryScreen:
        return MaterialPageRoute(
          builder: (_) => CaseHistoryScreen(admissionId: admissionId),
        );
      case Routes.forgotPasswordScreen:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordScreen(),
        );
      case Routes.resetPasswordScreen:
        final email = arguments as String;
        return MaterialPageRoute(
          builder: (_) => ResetPasswordScreen(email: email),
        );
      case Routes.clinicalNotesScreen:
        return MaterialPageRoute(builder: (_) => const ClinicalNotesScreen());
      case Routes.fluidBalanceScreen:
        return MaterialPageRoute(builder: (_) => const FluidBalanceScreen());
      case Routes.labResultsScreen:
        return MaterialPageRoute(builder: (_) => const LabResultsScreen());
      case Routes.clinicalAlertsScreen:
        return MaterialPageRoute(builder: (_) => const ClinicalAlertsScreen());
      case Routes.mainNavigationScreen:
        return MaterialPageRoute(builder: (_) => const MainNavigationScreen());
      case Routes.medicationScreen:
        return MaterialPageRoute(builder: (_) => const MedicationsScreen());
      case Routes.imagingScreen:
        return MaterialPageRoute(builder: (_) => const ImagingScreen());
      case Routes.chatbotScreen:
        return MaterialPageRoute(builder: (_) => const ChatbotScreen());
      case Routes.newPatientRegistrationScreen:
        return MaterialPageRoute(
          builder: (_) => const NewPatientRegistrationScreen(),
        );
      case Routes.patientDashboardScreen:
        return MaterialPageRoute(
          builder: (_) => const PatientDashboardScreen(),
        );
      case Routes.patientListScreen:
        return MaterialPageRoute(builder: (_) => const PatientListScreen());
      case Routes.physicalExaminationScreen:
        return MaterialPageRoute(
          builder: (_) => const PhysicalExaminationScreen(),
        );
      case Routes.profileScreen:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      default:
        return null;
    }
  }
}
