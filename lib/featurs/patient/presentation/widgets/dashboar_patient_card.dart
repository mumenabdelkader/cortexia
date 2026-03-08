import 'package:flutter/material.dart';

class DashboarPatientCard extends StatelessWidget {
  final String name;
  final String id;
  final String status;
  final String genderAge;
  final String room;
  final String admittedDate;
  final String diagnosis;
  final String daysCount;

  const DashboarPatientCard({
    Key? key,
    this.name = "John Anderson",
    this.id = "PT-2024-1547",
    this.status = "Stable",
    this.genderAge = "Male, 45y",
    this.room = "ICU-101",
    this.admittedDate = "Jan 28, 2026",
    this.diagnosis = "Pneumonia",
    this.daysCount = "6 days",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F9FF), // لون خلفية مائل للزرقة فاتح جداً
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blue.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // الجزء العلوي: الصورة، الاسم، الـ ID والحالة
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
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "ID: $id",
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    // التاجات الصغيرة (Gender/Age & Room)
                    Row(
                      children: [
                        _buildSmallTag(genderAge, const Color(0xFFF1F5F9), Colors.black87),
                        const SizedBox(width: 8),
                        _buildSmallTag(room, const Color(0xFFE0F7FA), Colors.cyan[700]!),
                      ],
                    ),
                  ],
                ),
              ),
              _buildStatusBadge(status),
            ],
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(color: Color(0xFFE2E8F0), thickness: 1),
          ),

          // الجزء السفلي: البيانات الموزعة بالعرض
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDataColumn("Admitted", admittedDate),
              _buildDataColumn("Diagnosis", diagnosis),
              _buildDataColumn("Days", daysCount),
            ],
          ),
        ],
      ),
    );
  }

  // ميثود بناء العمود الصغير للبيانات
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

  // ميثود بناء التاجات (Male, 45y / ICU-101)
  Widget _buildSmallTag(String text, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: textColor.withOpacity(0.1)),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 11, fontWeight: FontWeight.w500),
      ),
    );
  }

  // ميثود الـ Status Badge
  Widget _buildStatusBadge(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF4CAF50), // اللون الأخضر كما في الصورة
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        status,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }
}