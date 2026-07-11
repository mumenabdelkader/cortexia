import 'package:cortexia/features/alerts/data/models/alert_model.dart';
import 'package:cortexia/features/alerts/data/models/override_alert_request.dart';
import 'package:cortexia/features/alerts/domain/repo/alerts_repo_interface.dart';
import 'package:cortexia/features/alerts/presentation/controllers/alerts_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlertsCubit extends Cubit<AlertsState> {
  final AlertsRepoInterface _alertsRepo;

  AlertsCubit(this._alertsRepo) : super(AlertsInitial());

  List<AlertModel> activeAlerts = [];

  Future<void> getActiveAlerts(String? admissionId) async {
    emit(AlertsLoading());
    final result = await _alertsRepo.getActiveAlerts(admissionId);
    result.when(
      onSuccess: (alertsData) {
        activeAlerts = alertsData;
        if (!isClosed) {
          emit(AlertsLoaded(activeAlerts));
        }
      },
      onError: (apiErrorModel) {
        if (!isClosed) {
          emit(AlertsError(message: apiErrorModel.messages.join('\n')));
        }
      },
    );
  }

  Future<void> overrideAlert(
    OverrideAlertRequest request,
    String admissionId,
  ) async {
    emit(OverrideAlertLoading());
    final result = await _alertsRepo.overrideAlert(request.alertId, request);

    result.when(
      onSuccess: (_) {
        emit(OverrideAlertSuccess('Alert overridden successfully'));
        // Refresh alerts after successful override
        getActiveAlerts(admissionId);
      },
      onError: (apiErrorModel) {
        emit(OverrideAlertError(message: apiErrorModel.messages.join('\n')));
        // Emit loaded state again to dismiss any loading overlays and show previous data
        emit(AlertsLoaded(activeAlerts));
      },
    );
  }
}
