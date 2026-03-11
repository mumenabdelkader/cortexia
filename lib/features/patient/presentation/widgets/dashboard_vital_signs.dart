
import 'package:cortexia/features/patient/presentation/ui/physical_examination_screen.dart';
import 'package:flutter/material.dart';

class DashboardVitalSigns extends StatelessWidget {
  const DashboardVitalSigns({super.key});

  @override
  Widget build(BuildContext context) {
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
          // العنوان العلوي للقسم
          Row(
            children: const [
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
          const SizedBox(height: 20),

          // توزيع العلامات الحيوية في شبكة (2 في كل صف)
          Column(
            children: [
              Row(
                children: [
                  _buildVitalItem(
                    label: "Heart Rate",
                    value: "82",
                    unit: "bpm",
                    icon: Icons.favorite_border,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 12),
                  _buildVitalItem(
                    label: "Temperature",
                    value: "37.2",
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
                    value: "120/80",
                    unit: "mmHg",
                    icon: Icons.timeline, // أو أيقونة نبض مناسبة
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 12),
                  _buildVitalItem(
                    label: "SpO2",
                    value: "98",
                    unit: "%",
                    icon: Icons.air,
                    color: Colors.blue,
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 20),

          // زر العرض الكامل في الأسفل
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => PhysicalExaminationScreen(),));
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    "View Full Examination",
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
  }

  // ميثود بناء كل كارت علامة حيوية صغير
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
          color: const Color(0xFFF8FAFC), // خلفية رمادية فاتحة جداً كما في الصورة
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 18),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
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