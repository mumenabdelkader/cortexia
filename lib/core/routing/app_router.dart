// Dependency Injection
import 'package:cortexia/features/patient/presentation/ui/clinical_alerts_screen.dart';
import 'package:flutter/material.dart';
import '../../features/authentication/presentation/ui/login_screen.dart';
import '../../features/case_history/presentation/ui/case_history_screen.dart';
import '../../features/patient/presentation/ui/chatbot_screen.dart';
import '../../features/patient/presentation/ui/new_patient_registration_screen.dart';
import '../../features/patient/presentation/ui/patient_dashboard_screen.dart';
import '../../features/patient/presentation/ui/patient_list_screen.dart';
import '../../features/patient/presentation/ui/physical_examination_screen.dart';
import '../../features/patient/presentation/ui/profile_screen.dart';
import '../../welcome_screens.dart';
import 'package:cortexia/features/authentication/presentation/ui/forgot_password_screen.dart';
import 'package:cortexia/features/authentication/presentation/ui/reset_password_screen.dart';
import '../../features/nursing_notes/presentation/ui/clinical_notes_screen.dart';
import '../../features/patient/presentation/ui/fluid_balance_screen.dart';
import '../../features/patient/presentation/ui/lab_results_screen.dart';
import '../../features/patient/presentation/ui/main_navigation_screen.dart';
import '../../features/medications/presentation/ui/medications_screen.dart';
import '../../features/patient/presentation/ui/imaging_screen.dart';
import 'package:cortexia/features/medications/presentation/controllers/medications_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'routes.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.medicalHistoryScreen:
        final admissionId =
            (arguments is Map ? arguments['admissionId'] : null) as String? ??
            '';
        return MaterialPageRoute(
          builder: (_) => CaseHistoryScreen(admissionId: admissionId),
        );
      case Routes.forgotPasswordScreen:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case Routes.resetPasswordScreen:
        final email = arguments as String;
        return MaterialPageRoute(
          builder: (_) => ResetPasswordScreen(email: email),
        );
      case Routes.clinicalNotesScreen:
        final admissionId =
            (arguments is Map ? arguments['admissionId'] : null) as String? ?? '';
        return MaterialPageRoute(
          builder: (_) => ClinicalNotesScreen(admissionId: admissionId),
        );
      case Routes.fluidBalanceScreen:
        return MaterialPageRoute(builder: (_) => const FluidBalanceScreen());
      case Routes.labResultsScreen:
        return MaterialPageRoute(builder: (_) => const LabResultsScreen());
      case Routes.clinicalAlertsScreen:
        return MaterialPageRoute(builder: (_) => const ClinicalAlertsScreen());
      case Routes.mainNavigationScreen:
        return MaterialPageRoute(builder: (_) => const MainNavigationScreen());
      case Routes.medicationScreen:
        final args = arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => MedicationsCubit(GetIt.I.get()),
            child: MedicationsScreen(
              admissionId: args?['admissionId'] ?? '',
              doctorId: args?['doctorId'] ?? 'DOC-1436C0633BBD',
            ),
          ),
        );
      case Routes.imagingScreen:
        return MaterialPageRoute(builder: (_) => const ImagingScreen());
      case Routes.chatbotScreen:
        return MaterialPageRoute(builder: (_) => const ChatbotScreen());
      case Routes.newPatientRegistrationScreen:
        return MaterialPageRoute(
          builder: (_) => const NewPatientRegistrationScreen(),
        );
      case Routes.patientDashboardScreen:
        final id = arguments is String
            ? arguments
            : (arguments is Map ? arguments['patientId'] : null);
        return MaterialPageRoute(
          builder: (_) => PatientDashboardScreen(patientId: id as String?),
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
