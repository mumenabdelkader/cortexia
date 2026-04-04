import 'package:cortexia/core/routing/routes.dart';
import 'package:cortexia/features/vital_signs/presentation/controllers/vital_signs_cubit.dart';
import 'package:cortexia/features/vital_signs/presentation/controllers/vital_signs_opreations_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class DashboardVitalSigns extends StatelessWidget {
  final String? admissionId;
  const DashboardVitalSigns({super.key, this.admissionId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = VitalSignsCubit(GetIt.I.get());
        if (admissionId != null && admissionId!.isNotEmpty) {
          cubit.getAdmissionsAdmissionidVitals(admissionid: admissionId!);
        }
        return cubit;
      },
      child: BlocBuilder<VitalSignsCubit, VitalSignsState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade100),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.show_chart, color: Colors.blue, size: 22),
                        SizedBox(width: 8),
                        Text(
                          "Vital Signs",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                      ],
                    ),
                    if (state is VitalSignsStateLoading)
                      const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                  ],
                ),
                const SizedBox(height: 20),

                // Content
                _buildContent(context, state),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        Routes.vitalSignsScreen,
                        arguments: {'admissionId': admissionId},
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          "View All Vital Signs",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_forward, size: 16, color: Colors.blue),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, VitalSignsState state) {
    if (state is VitalSignsStateLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (state is VitalSignsStateError) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Center(
          child: Column(
            children: [
              Icon(Icons.error_outline, color: Colors.red.shade300, size: 40),
              const SizedBox(height: 8),
              Text(
                state.message,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red.shade400, fontSize: 13),
              ),
            ],
          ),
        ),
      );
    }

    // Extract vitals from success state or fall back to placeholders
    Map<String, dynamic>? vitals;
    if (state is VitalSignsStateSuccess &&
        state.operation == kGetAdmissionsAdmissionidVitals) {
      try {
        final data = state.data;
        if (data is List && data.isNotEmpty) {
          // Most recent vital signs record
          vitals = Map<String, dynamic>.from(data.first as Map);
        } else if (data is Map) {
          vitals = Map<String, dynamic>.from(data);
        }
      } catch (_) {}
    }

    final heartRate = vitals?['heartRate']?.toString() ?? '--';
    final temperature = vitals?['temperature']?.toString() ?? '--';
    final bpSystolic = vitals?['bP_Systolic']?.toString();
    final bpDiastolic = vitals?['bP_Diastolic']?.toString();
    final bloodPressure = (bpSystolic != null && bpDiastolic != null)
        ? '$bpSystolic/$bpDiastolic'
        : '--';
    final spo2 = vitals?['pulseOxy']?.toString() ?? '--';

    if (admissionId == null || admissionId!.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Center(
          child: Text(
            'No admission selected.',
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
        ),
      );
    }

    return Column(
      children: [
        Row(
          children: [
            _buildVitalItem(
              label: "Heart Rate",
              value: heartRate,
              unit: "bpm",
              icon: Icons.favorite_border,
              color: Colors.blue,
            ),
            const SizedBox(width: 12),
            _buildVitalItem(
              label: "Temperature",
              value: temperature,
              unit: "°C",
              icon: Icons.thermostat,
              color: Colors.blue,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildVitalItem(
              label: "Blood Pressure",
              value: bloodPressure,
              unit: "mmHg",
              icon: Icons.timeline,
              color: Colors.blue,
            ),
            const SizedBox(width: 12),
            _buildVitalItem(
              label: "SpO2",
              value: spo2,
              unit: "%",
              icon: Icons.air,
              color: Colors.blue,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVitalItem({
    required String label,
    required String value,
    required String unit,
    required IconData icon,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 18),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    label,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  unit,
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
