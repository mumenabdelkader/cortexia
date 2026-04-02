import 'package:cortexia/features/admission/data/apis/admission_service.dart';
import 'package:cortexia/features/admission/data/repo/admission_repo_impl.dart';
import 'package:cortexia/features/admission/domain/repo/admission_repo_interface.dart';
import 'package:cortexia/features/authentication/data/apis/auth_service.dart';
import 'package:cortexia/features/authentication/data/repo/repo_imp.dart';
import 'package:cortexia/features/authentication/domain/repo/repo_interface.dart';

// Features
import 'package:cortexia/features/case_history/data/apis/case_history_service.dart';
import 'package:cortexia/features/case_history/data/repo/case_history_repo_imp.dart';
import 'package:cortexia/features/case_history/domain/repo/repo_interface.dart';
import 'package:cortexia/features/case_history/presentation/controllers/case_history_cubit.dart';
import 'package:cortexia/features/diagnostics/data/apis/diagnostics_service.dart';
import 'package:cortexia/features/diagnostics/data/repo/diagnostics_repo_imp.dart';
import 'package:cortexia/features/diagnostics/domain/repo/repo_interface.dart';
import 'package:cortexia/features/diagnostics/presentation/controllers/diagnostics_cubit.dart';
import 'package:cortexia/features/fluid_balance/data/apis/fluid_balance_service.dart';
import 'package:cortexia/features/fluid_balance/data/repo/fluid_balance_repo_imp.dart';
import 'package:cortexia/features/fluid_balance/domain/repo/repo_interface.dart';
import 'package:cortexia/features/fluid_balance/presentation/controllers/fluid_balance_cubit.dart';
import 'package:cortexia/features/intervention_procedures/data/apis/intervention_procedures_service.dart';
import 'package:cortexia/features/intervention_procedures/data/repo/intervention_procedures_repo_imp.dart';
import 'package:cortexia/features/intervention_procedures/domain/repo/repo_interface.dart';
import 'package:cortexia/features/intervention_procedures/presentation/controllers/intervention_procedures_cubit.dart';
import 'package:cortexia/features/medications/data/apis/medications_service.dart';
import 'package:cortexia/features/medications/data/repo/medications_repo_imp.dart';
import 'package:cortexia/features/medications/domain/repo/repo_interface.dart';
import 'package:cortexia/features/medications/presentation/controllers/medications_cubit.dart';
import 'package:cortexia/features/nursing_notes/data/apis/nursing_notes_service.dart';
import 'package:cortexia/features/nursing_notes/data/repo/nursing_notes_repo_imp.dart';
import 'package:cortexia/features/nursing_notes/domain/repo/repo_interface.dart';
import 'package:cortexia/features/nursing_notes/presentation/controllers/nursing_notes_cubit.dart';
import 'package:cortexia/features/patients/data/apis/patients_service.dart';
import 'package:cortexia/features/patients/data/repo/patients_repo_imp.dart';
import 'package:cortexia/features/patients/domain/repo/repo_interface.dart';
import 'package:cortexia/features/patients/presentation/controllers/patients_cubit.dart';
import 'package:cortexia/features/physical_examination/data/apis/physical_examination_service.dart';
import 'package:cortexia/features/physical_examination/data/repo/physical_examination_repo_imp.dart';
import 'package:cortexia/features/physical_examination/domain/repo/repo_interface.dart';
import 'package:cortexia/features/physical_examination/presentation/controllers/physical_examination_cubit.dart';
import 'package:cortexia/features/vital_signs/data/apis/vital_signs_service.dart';
import 'package:cortexia/features/vital_signs/data/repo/vital_signs_repo_imp.dart';
import 'package:cortexia/features/vital_signs/domain/repo/repo_interface.dart';
import 'package:cortexia/features/vital_signs/presentation/controllers/vital_signs_cubit.dart';

import 'package:get_it/get_it.dart';

// Core
import '../api_helper/api_helper.dart';
import '../api_helper/dio_helper.dart';

final GetIt locator = GetIt.instance;

Future<void> setupGetIt() async {
  /* ------------------------------ CORE ---------------------------------- */

  locator.registerLazySingleton<ApiHelper>(() => DioHelper());

  final dio = (locator<ApiHelper>() as DioHelper).dio;

  /* --------------------------- AUTH FEATURE ------------------------------ */

  locator.registerLazySingleton<AuthService>(() => AuthService(dio));

  // 2. تسجيل الـ Repository
  locator.registerLazySingleton<AuthRepoInterface>(
    () => AuthRepositoryImp(locator<AuthService>()),
  );

  /* --------------------------- ADMISSION FEATURE ------------------------------ */

  // 1. تسجيل الـ API Service
  locator.registerLazySingleton<AdmissionService>(() => AdmissionService(dio));

  // 2. تسجيل الـ Repository
  locator.registerLazySingleton<AdmissionRepoInterface>(
    () => AdmissionRepoImpl(locator<AdmissionService>()),
  );

  /* ---------------------- CASE HISTORY FEATURE --------------------------- */
  locator.registerLazySingleton<CaseHistoryService>(
    () => CaseHistoryService(dio),
  );
  locator.registerLazySingleton<CaseHistoryRepoInterface>(
    () => CaseHistoryRepoImp(locator<CaseHistoryService>()),
  );
  locator.registerFactory<CaseHistoryCubit>(
    () => CaseHistoryCubit(locator<CaseHistoryRepoInterface>()),
  );

  /* ---------------------- DIAGNOSTICS FEATURE ---------------------------- */
  locator.registerLazySingleton<DiagnosticsService>(
    () => DiagnosticsService(dio),
  );
  locator.registerLazySingleton<DiagnosticsRepoInterface>(
    () => DiagnosticsRepoImp(locator<DiagnosticsService>()),
  );
  locator.registerFactory<DiagnosticsCubit>(
    () => DiagnosticsCubit(locator<DiagnosticsRepoInterface>()),
  );

  /* ---------------------- FLUID BALANCE FEATURE -------------------------- */
  locator.registerLazySingleton<FluidBalanceService>(
    () => FluidBalanceService(dio),
  );
  locator.registerLazySingleton<FluidBalanceRepoInterface>(
    () => FluidBalanceRepoImp(locator<FluidBalanceService>()),
  );
  locator.registerFactory<FluidBalanceCubit>(
    () => FluidBalanceCubit(locator<FluidBalanceRepoInterface>()),
  );

  /* ------------------ INTERVENTION PROCEDURES FEATURE -------------------- */
  locator.registerLazySingleton<InterventionProceduresService>(
    () => InterventionProceduresService(dio),
  );
  locator.registerLazySingleton<InterventionProceduresRepoInterface>(
    () =>
        InterventionProceduresRepoImp(locator<InterventionProceduresService>()),
  );
  locator.registerFactory<InterventionProceduresCubit>(
    () => InterventionProceduresCubit(
      locator<InterventionProceduresRepoInterface>(),
    ),
  );
  /* ---------------------- MEDICATIONS FEATURE ---------------------------- */
  locator.registerLazySingleton<MedicationsService>(
    () => MedicationsService(dio),
  );
  locator.registerLazySingleton<MedicationsRepoInterface>(
    () => MedicationsRepoImp(locator<MedicationsService>()),
  );
  locator.registerFactory<MedicationsCubit>(
    () => MedicationsCubit(locator<MedicationsRepoInterface>()),
  );
  /* ---------------------- NURSING NOTES FEATURE -------------------------- */
  locator.registerLazySingleton<NursingNotesService>(
    () => NursingNotesService(dio),
  );
  locator.registerLazySingleton<NursingNotesRepoInterface>(
    () => NursingNotesRepoImp(locator<NursingNotesService>()),
  );
  locator.registerFactory<NursingNotesCubit>(
    () => NursingNotesCubit(locator<NursingNotesRepoInterface>()),
  );
  /* ------------------------ PATIENTS FEATURE ----------------------------- */
  locator.registerLazySingleton<PatientsService>(() => PatientsService(dio));
  locator.registerLazySingleton<PatientsRepoInterface>(
    () => PatientsRepoImp(locator<PatientsService>()),
  );
  locator.registerFactory<PatientsCubit>(
    () => PatientsCubit(locator<PatientsRepoInterface>()),
  );
  /* ------------------ PHYSICAL EXAMINATION FEATURE ----------------------- */
  locator.registerLazySingleton<PhysicalExaminationService>(
    () => PhysicalExaminationService(dio),
  );
  locator.registerLazySingleton<PhysicalExaminationRepoInterface>(
    () => PhysicalExaminationRepoImp(locator<PhysicalExaminationService>()),
  );
  locator.registerFactory<PhysicalExaminationCubit>(
    () => PhysicalExaminationCubit(locator<PhysicalExaminationRepoInterface>()),
  );
  /* ----------------------- VITAL SIGNS FEATURE --------------------------- */
  locator.registerLazySingleton<VitalSignsService>(
    () => VitalSignsService(dio),
  );
  locator.registerLazySingleton<VitalSignsRepoInterface>(
    () => VitalSignsRepoImp(locator<VitalSignsService>()),
  );
  locator.registerFactory<VitalSignsCubit>(
    () => VitalSignsCubit(locator<VitalSignsRepoInterface>()),
  );
}
