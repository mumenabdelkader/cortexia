import 'package:cortexia/features/patient/presentation/widgets/custom_info_card.dart';
import 'package:flutter/material.dart';
import 'package:cortexia/core/themes/color_themes.dart';

class PatientCard extends StatelessWidget {
  final String name;
  final String patientId;
  final String status;
  final String diagnosis;
  final String? age;
  final String? gender;
  final String? bloodType;
  final String? phone;
  final String? email;
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
    this.age,
    this.gender,
    this.bloodType,
    this.phone,
    this.email,
    this.hrValue = "—",
    this.tempValue = "—",
    this.bpValue = "—",
    this.spo2Value = "—",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // ── Header: avatar, name, ID, status badge ──────────────────────
          Row(
            children: [
              _buildAvatar(),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildStatusBadge(status),
                  if (bloodType != null) ...[
                    const SizedBox(height: 4),
                    _buildBloodTypeBadge(bloodType!),
                  ],
                ],
              ),
            ],
          ),

          const SizedBox(height: 14),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          const SizedBox(height: 14),

          // ── Patient details grid ─────────────────────────────────────────
          _buildDetailRow(
            icon: Icons.assignment_outlined,
            label: "Diagnosis",
            value: diagnosis,
            iconColor: Colors.blue,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildDetailRow(
                  icon: Icons.cake_outlined,
                  label: "Age",
                  value: age != null ? "$age yrs" : "—",
                  iconColor: Colors.purple,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDetailRow(
                  icon: Icons.wc_outlined,
                  label: "Gender",
                  value: gender ?? "—",
                  iconColor: Colors.teal,
                ),
              ),
            ],
          ),
          if (phone != null || email != null) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                if (phone != null)
                  Expanded(
                    child: _buildDetailRow(
                      icon: Icons.phone_outlined,
                      label: "Phone",
                      value: phone!,
                      iconColor: Colors.green,
                    ),
                  ),
                if (phone != null && email != null) const SizedBox(width: 12),
                if (email != null)
                  Expanded(
                    child: _buildDetailRow(
                      icon: Icons.email_outlined,
                      label: "Email",
                      value: email!,
                      iconColor: Colors.orange,
                    ),
                  ),
              ],
            ),
          ],

          const SizedBox(height: 14),

          // ── Vital Signs mini-cards ───────────────────────────────────────
          Row(
            children: [
              Expanded(
                child: CustomInfoCard(
                  title: "HR",
                  value: hrValue,
                  icon: Icons.insights,
                  themeColor: AppColors.primaryBlue,
                  bgColor: const Color(0xFFEDF2F7),
                  isSmall: true,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CustomInfoCard(
                  title: "Temp",
                  value: tempValue,
                  icon: Icons.thermostat,
                  themeColor: AppColors.errorRed,
                  bgColor: const Color(0xFFEDF2F7),
                  isSmall: true,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CustomInfoCard(
                  title: "BP",
                  value: bpValue,
                  icon: Icons.speed,
                  themeColor: Colors.teal,
                  bgColor: const Color(0xFFEDF2F7),
                  isSmall: true,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CustomInfoCard(
                  title: "SpO2",
                  value: spo2Value,
                  icon: Icons.bubble_chart_outlined,
                  themeColor: Colors.green,
                  bgColor: const Color(0xFFEDF2F7),
                  isSmall: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    final initials = name.trim().isNotEmpty
        ? name.trim().split(' ').map((w) => w[0]).take(2).join().toUpperCase()
        : '?';
    return CircleAvatar(
      radius: 26,
      backgroundColor: const Color(0xFFE2E8F0),
      child: Text(
        initials,
        style: const TextStyle(
          color: AppColors.primaryBlue,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    final isStable = status.toLowerCase() == "stable";
    final isActive = status.toLowerCase() == "active";
    Color color = isStable
        ? Colors.green
        : isActive
        ? Colors.blue
        : Colors.orange;
    Color bg = isStable
        ? Colors.green.shade50
        : isActive
        ? Colors.blue.shade50
        : Colors.orange.shade50;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildBloodTypeBadge(String type) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bloodtype_outlined, size: 11, color: Colors.red.shade400),
          const SizedBox(width: 3),
          Text(
            type,
            style: TextStyle(
              color: Colors.red.shade600,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
  }) {
    return Row(
      children: [
        Icon(icon, size: 14, color: iconColor),
        const SizedBox(width: 5),
        Text(
          "$label: ",
          style: TextStyle(color: Colors.grey[500], fontSize: 12),
        ),
        Flexible(
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          ),
        ),
      ],
    );
  }
}
