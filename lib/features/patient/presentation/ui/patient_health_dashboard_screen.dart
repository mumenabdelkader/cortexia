import 'package:cortexia/core/widgets/custom_app_bar.dart';
import 'package:cortexia/features/vital_signs/data/models/vitals_model.dart';
import 'package:cortexia/features/patient/presentation/ui/patient_health_chart.dart';
import 'package:cortexia/features/patient/presentation/widgets/legend_indicator.dart';
import 'package:flutter/material.dart';

class PatientVitalDashboardScreen extends StatelessWidget {
  final List<VitalsModel> items;

  const PatientVitalDashboardScreen({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Patient vital Signs chart'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              // تمرير القائمة هنا
              child: PatientVitalChart(records: items),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 16,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: const [
                LegendIndicator(color: Colors.red, text: 'Temperature'),
                LegendIndicator(color: Colors.indigo, text: 'Sys BP'),
                LegendIndicator(color: Colors.lightBlue, text: 'Dia BP'),
                LegendIndicator(color: Colors.orange, text: 'Heart Rate'),
                LegendIndicator(color: Colors.purple, text: 'Resp Rate'),
                LegendIndicator(color: Colors.green, text: 'SpO2'),
                LegendIndicator(color: Colors.brown, text: 'Suppl. O2'),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}