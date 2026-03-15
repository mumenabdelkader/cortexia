import 'package:cortexia/features/patient/presentation/widgets/custom_info_card.dart';
import 'package:flutter/material.dart';
import 'package:cortexia/core/themes/color_themes.dart';

class PatientCard extends StatelessWidget {
  final String name;
  final String patientId;
  final String status;
  final String diagnosis;
  final String admissionDate;
  final String hrValue;
  final String tempValue;
  final String bpValue;
  final String spo2Value;

  const PatientCard({
    super.key,
    required this.name,
    required this.patientId,
    required this.status,
    required this.diagnosis,
    required this.admissionDate,
    this.hrValue = "0",
    this.tempValue = "0",
    this.bpValue = "0/0",
    this.spo2Value = "0%",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16), // مسافة بين الكروت
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border.withValues(alpha:0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // الجزء العلوي: الصورة والاسم والحالة
          Row(
            children: [
              const CircleAvatar(
                radius: 25,
                backgroundColor: Color(0xFFE2E8F0),
                child: Icon(Icons.person, color: AppColors.primaryBlue),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      patientId,
                      style: TextStyle(color: Colors.grey[500], fontSize: 12),
                    ),
                  ],
                ),
              ),
              _buildStatusBadge(status),
            ],
          ),

          const SizedBox(height: 20),
          _buildDetailRow("Diagnosis:", diagnosis),
          const SizedBox(height: 8),
          _buildDetailRow("Admitted:", admissionDate),
          const SizedBox(height: 20),

          // كروت العلامات الحيوية (isSmall: true)
          Row(
            children: [
              CustomInfoCard(
                title: "HR",
                value: hrValue,
                icon: Icons.insights,
                themeColor: AppColors.primaryBlue,
                bgColor: const Color(0xFFEDF2F7),
                isSmall: true,
              ),
              const SizedBox(width: 8),
              CustomInfoCard(
                title: "Temp",
                value: tempValue,
                icon: Icons.thermostat,
                themeColor: AppColors.errorRed,
                bgColor: const Color(0xFFEDF2F7),
                isSmall: true,
              ),
              const SizedBox(width: 8),
              CustomInfoCard(
                title: "BP",
                value: bpValue,
                icon: Icons.speed,
                themeColor: Colors.teal,
                bgColor: const Color(0xFFEDF2F7),
                isSmall: true,
              ),
              const SizedBox(width: 8),
              CustomInfoCard(
                title: "SpO2",
                value: spo2Value,
                icon: Icons.bubble_chart_outlined,
                themeColor: Colors.green,
                bgColor: const Color(0xFFEDF2F7),
                isSmall: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ميثود فرعية للـ Badge
  Widget _buildStatusBadge(String status) {
    bool isStable = status.toLowerCase() == "stable";
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isStable ? Colors.green[50] : Colors.orange[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: isStable ? Colors.green : Colors.orange,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  // ميثود فرعية لصفوف البيانات
  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
      ],
    );
  }
}