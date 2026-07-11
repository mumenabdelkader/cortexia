import 'package:cortexia/features/alerts/data/models/alert_model.dart';

abstract class AlertsState {}

class AlertsInitial extends AlertsState {}

class AlertsLoading extends AlertsState {}

class AlertsLoaded extends AlertsState {
  final List<AlertModel> activeAlerts;

  AlertsLoaded(this.activeAlerts);
}

class AlertsError extends AlertsState {
  final String message;

  AlertsError({required this.message});
}

class OverrideAlertLoading extends AlertsState {}

class OverrideAlertSuccess extends AlertsState {
  final String message;

  OverrideAlertSuccess(this.message);
}

class OverrideAlertError extends AlertsState {
  final String message;

  OverrideAlertError({required this.message});
}
