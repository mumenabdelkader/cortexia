import 'package:cortexia/features/patient/presentation/ui/chatbot_screen.dart';
import 'package:cortexia/features/patient/presentation/ui/imaging_screen.dart';
import 'package:cortexia/features/patient/presentation/ui/medications_screen.dart';
import 'package:cortexia/features/patient/presentation/widgets/dashboar_patient_card.dart';
import 'package:cortexia/features/patient/presentation/widgets/dashboard_action_card.dart';
import 'package:cortexia/features/patient/presentation/widgets/dashboard_active_medications.dart';
import 'package:cortexia/features/patient/presentation/widgets/dashboard_current_alerts.dart';
import 'package:cortexia/features/patient/presentation/widgets/dashboard_vital_signs.dart';
import 'package:flutter/material.dart';
import 'package:cortexia/core/widgets/custom_app_bar.dart'; // تأكد من المسار الصحيح
import 'package:cortexia/core/widgets/custom_elevated_button.dart'; // تأكد من المسار الصحيح

// استيراد الـ Widgets اللي عملناها سابقاً للـ Dashboard

class PatientDashboardScreen extends StatelessWidget {
  const PatientDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      // 1. استخدام الـ CustomAppBar اللي لسه عامله
      appBar: const CustomAppBar(
        title: "Patient Dashboard",
        subtitle: "Dr. Sarah Johnson",
        // استخدمنا الـ Trailing اللي عملناه فيه أيقونة الإشعارات و الـ Badge
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const DashboarPatientCard(),
            const SizedBox(height: 16),
            const DashboardCurrentAlerts(),
            const SizedBox(height: 16),
            const DashboardVitalSigns(),
            const SizedBox(height: 16),
            GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MedicationsScreen(),))    ;
                },
                child: const DashboardActiveMedications()),
            const SizedBox(height: 20),

            // 2. استخدام الـ CustomElevatedButton لزر الـ AI
            CustomElevatedButton(
              text: "Chat With AI",
              borderRadius: 15,
              // مررنا التدرج السماوي الخاص بالـ AI كما في الصورة
              gradient: const LinearGradient(
                colors: [Color(0xFF00D2FF), Color(0xFF00E5FF)],
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatbotScreen(),))    ;
                },
            ),

            const SizedBox(height: 20),
            _buildActionGrid(context),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildActionGrid(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            Expanded(
              child: DashboardActionCard(
                title: "Clinical Notes",
                subTitle: "View timeline",
                icon: Icons.description_outlined,
                iconColor: Colors.blue,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: DashboardActionCard(
                title: "Lab Results",
                subTitle: "Check reports",
                icon: Icons.analytics_outlined,
                iconColor: Colors.teal,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: const [
            Expanded(
              child: DashboardActionCard(
                title: "Medical History",
                subTitle: "View records",
                icon: Icons.assignment_outlined,
                iconColor: Colors.orange,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: DashboardActionCard(
                title: "Fluid Balance",
                subTitle: "I/O tracking",
                icon: Icons.water_drop_outlined,
                iconColor: Colors.green,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children:  [
            Expanded(
              child:GestureDetector (
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MedicationsScreen(),))    ;
                },
                child: DashboardActionCard(
                  title: "Medication",
                  subTitle: "View records",
                  icon: Icons.image_outlined,
                  iconColor: Colors.purpleAccent,
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ImagingScreen(),))    ;
                },
                child: DashboardActionCard(
                  title: "imaging",
                  subTitle: "I/O tracking",
                  icon: Icons.medication_liquid,
                  iconColor: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}