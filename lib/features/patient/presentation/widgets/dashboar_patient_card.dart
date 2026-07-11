import 'package:flutter/material.dart';

class DashboarPatientCard extends StatelessWidget {
  final String? name;
  final String? id;
  final String? status;
  final String? genderAge;
  final String? room;
  final String? admittedDate;
  final String? diagnosis;
  final String? daysCount;

  const DashboarPatientCard({
    super.key,
    this.name,
    this.id,
    this.status,
    this.genderAge,
    this.room,
    this.admittedDate,
    this.diagnosis,
    this.daysCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Upper section: Avatar, name, ID, status
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundColor: Color(0xFFE0F2FE),
                child: Icon(Icons.person_outline, color: Colors.blue, size: 30),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name ?? "N/A",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "ID: ${id ?? "N/A"}",
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    // Small tags (Gender/Age & Room)
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        _buildSmallTag(genderAge ?? "N/A", const Color(0xFFF1F5F9), Colors.black87),
                        _buildSmallTag(room ?? "N/A", const Color(0xFFE0F7FA), Colors.cyan[700]!),
                      ],
                    ),
                  ],
                ),
              ),
              _buildStatusBadge(status ?? "Stable"),
            ],
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(color: Color(0xFFE2E8F0), thickness: 1),
          ),

          // Lower section: data rows
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: _buildDataColumn("Admitted", admittedDate ?? "N/A")),
              const SizedBox(width: 16),
              Expanded(child: _buildDataColumn("Days", daysCount ?? "N/A")),
            ],
          ),
          const SizedBox(height: 16),
          _buildDataColumn("Diagnosis", diagnosis ?? "N/A"),
        ],
      ),
    );
  }

  Widget _buildDataColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Color(0xFF64748B), fontSize: 12),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(0xFF1E293B),
          ),
        ),
      ],
    );
  }

  Widget _buildSmallTag(String text, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: textColor.withValues(alpha: 0.1)),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 11, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    final statusLower = status.toLowerCase();
    final isCritical = statusLower == 'critical';
    final isStable = statusLower == 'stable';
    
    final Color badgeColor = isCritical 
        ? const Color(0xFFEF4444) 
        : (isStable ? const Color(0xFF10B981) : const Color(0xFF3B82F6));
        
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: badgeColor.withValues(alpha: 0.25),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        status,
        style: const TextStyle(
          color: Colors.white, 
          fontWeight: FontWeight.bold, 
          fontSize: 12,
        ),
      ),
    );
  }
}