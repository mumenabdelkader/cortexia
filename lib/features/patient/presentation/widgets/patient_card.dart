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

  // ── Location (resolved from RoomCacheService) ───────────────────────────
  final int? floor;
  final String? roomNumber;
  final String? bedNumber;
  final String? roomType;

  // ── Vital signs ─────────────────────────────────────────────────────────
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
    this.floor,
    this.roomNumber,
    this.bedNumber,
    this.roomType,
    this.hrValue = "—",
    this.tempValue = "—",
    this.bpValue = "—",
    this.spo2Value = "—",
  });

  @override
  Widget build(BuildContext context) {
    final hasLocation =
        floor != null || roomNumber != null || bedNumber != null;

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──────────────────────────────────────────────────────
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
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Text(
                          "ID: $patientId",
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (age != null) ...[
                          const SizedBox(width: 8),
                          Container(
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "$age yrs",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildStatusBadge(status),
                  if (bloodType != null) ...[
                    const SizedBox(height: 6),
                    _buildBloodTypeBadge(bloodType!),
                  ],
                ],
              ),
            ],
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1, color: Color(0xFFF1F5F9)),
          ),

          // ── Diagnosis ────────────────────────────────────────────────────
          _buildDetailRow(
            icon: Icons.assignment_outlined,
            label: "Diagnosis",
            value: diagnosis,
            iconColor: Colors.blue[600]!,
          ),

          // ── Location badge ───────────────────────────────────────────────
          if (hasLocation) ...[
            const SizedBox(height: 10),
            _buildLocationBadge(),
          ],

          const SizedBox(height: 16),

          // ── Vital Signs Mini Cards ────────────────────────────────────────
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
                  themeColor: Colors.teal[700]!,
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
                  themeColor: Colors.green[700]!,
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

  // ── Location badge ──────────────────────────────────────────────────────

  Widget _buildLocationBadge() {
    // Pick accent colour based on room type
    final Color accent = _roomTypeColor();
    final Color bgColor = accent.withValues(alpha: 0.07);
    final Color borderColor = accent.withValues(alpha: 0.18);

    return IntrinsicWidth(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Floor chip
            if (floor != null) ...[
              _locationChip(
                icon: Icons.layers_outlined,
                label: "Floor ${floor!}",
                color: accent,
              ),
              _divider(accent),
            ],

            // Room chip
            if (roomNumber != null) ...[
              _locationChip(
                icon: Icons.door_front_door_outlined,
                label: roomNumber!,
                color: accent,
              ),
              _divider(accent),
            ],

            // Bed chip
            if (bedNumber != null)
              _locationChip(
                icon: Icons.single_bed_outlined,
                label: bedNumber!,
                color: accent,
              ),

            // Room type tag
            if (roomType != null && roomType != 'Unknown') ...[
              _divider(accent),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  roomType!,
                  style: TextStyle(
                    color: accent,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _locationChip({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: color),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            color: color.withValues(alpha: 0.9),
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _divider(Color color) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 7),
    child: Container(
      width: 1,
      height: 12,
      color: color.withValues(alpha: 0.25),
    ),
  );

  /// Maps room type label to a meaningful accent colour.
  Color _roomTypeColor() {
    switch (roomType?.toLowerCase()) {
      case 'icu':
        return const Color(0xFFDC2626); // red
      case 'emergency':
        return const Color(0xFFD97706); // amber
      case 'private':
        return const Color(0xFF7C3AED); // purple
      case 'operation':
        return const Color(0xFF0284C7); // sky blue
      default:
        return const Color(0xFF0D9488); // teal (Ward / unknown)
    }
  }

  // ── Avatar ──────────────────────────────────────────────────────────────

  Widget _buildAvatar() {
    final initials = name.trim().isNotEmpty
        ? name.trim().split(' ').map((w) => w[0]).take(2).join().toUpperCase()
        : '?';

    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF007ADF), Color(0xFF002B56)],
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF007ADF).withValues(alpha: 0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Text(
          initials,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  // ── Status badge ─────────────────────────────────────────────────────────

  Widget _buildStatusBadge(String status) {
    final statusLower = status.toLowerCase();
    final isCritical = statusLower == 'critical';
    final isStable = statusLower == 'stable';

    final Color badgeColor = isCritical
        ? const Color(0xFFEF4444)
        : (isStable ? const Color(0xFF10B981) : const Color(0xFF3B82F6));

    final Color bg = isCritical
        ? const Color(0xFFFEF2F2)
        : (isStable ? const Color(0xFFECFDF5) : const Color(0xFFEFF6FF));

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: badgeColor.withValues(alpha: 0.15)),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: badgeColor,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  // ── Blood type badge ─────────────────────────────────────────────────────

  Widget _buildBloodTypeBadge(String type) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF5F5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.withValues(alpha: 0.15)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bloodtype_outlined, size: 12, color: Colors.red[600]),
          const SizedBox(width: 3),
          Text(
            type,
            style: TextStyle(
              color: Colors.red[600],
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  // ── Detail row ───────────────────────────────────────────────────────────

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: Icon(icon, size: 14, color: iconColor),
        ),
        const SizedBox(width: 6),
        Text(
          "$label: ",
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: Color(0xFF1E293B),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
