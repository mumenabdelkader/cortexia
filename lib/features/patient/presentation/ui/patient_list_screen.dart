import 'package:cortexia/features/patient/presentation/ui/patient_dashboard_screen.dart';
import 'package:cortexia/features/patient/presentation/widgets/custom_info_card.dart';
import 'package:flutter/material.dart';
import 'package:cortexia/core/widgets/custom_app_bar.dart';
import 'package:cortexia/core/widgets/custom_form_field.dart';
import 'package:cortexia/features/patient/presentation/widgets/department_banner.dart';
import 'package:cortexia/features/patient/presentation/widgets/patient_card.dart';
import 'package:cortexia/core/themes/color_themes.dart';

// استيراد الـ Trailing الجديد
import 'package:cortexia/features/patient/presentation/widgets/app_bar_trailing.dart';

class PatientListScreen extends StatelessWidget {
  const PatientListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: CustomAppBar(
        title: "Patient List",
        subtitle: "Dr. Sarah Johnson",
        // استخدام الكلاس المنفصل هنا
        trailing: const AppBarTrailing(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 1. خانة البحث
            const CustomTextFormField(
              hintText: "Search by name, ID, or diagnosis...",
              prefixIcon: Icons.search,
              fillColor:Colors.white70 ,

            ),

            const SizedBox(height: 16),

            // 2. بانر القسم
            const DepartmentBanner(
              departmentName: "Internal Medicine",
              patientCount: 5,
            ),

            const SizedBox(height: 16),

            // 3. كروت الإحصائيات (isSmall: false)
            Row(
              children: [
                CustomInfoCard(
                  title: "Total Patients",
                  value: "5",
                  icon: Icons.people_alt_outlined,
                  themeColor: AppColors.primaryBlue,
                  bgColor: AppColors.infoBg,
                  isSmall: false,
                ),
                const SizedBox(width: 10),
                CustomInfoCard(
                  title: "Critical Cases",
                  value: "1",
                  icon: Icons.report_problem_outlined,
                  themeColor: AppColors.errorRed,
                  bgColor: AppColors.errorBg,
                  isSmall: false,
                ),
                const SizedBox(width: 10),
                CustomInfoCard(
                  title: "Active Alerts",
                  value: "8",
                  icon: Icons.notifications_active_outlined,
                  themeColor: Colors.orange,
                  bgColor: const Color(0xFFFFF7ED),
                  isSmall: false,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // 4. كروت المرضى (الآن نمرر البيانات فقط)
             GestureDetector(
               child: PatientCard(
                name: "John Anderson",
                patientId: "PT-2024-1547",
                status: "Stable",
                diagnosis: "Pneumonia",
                admissionDate: "Jan 28, 2026 (6 days)",
                hrValue: "82",
                tempValue: "37.2°",
                bpValue: "120/80",
                spo2Value: "98%",
                           ),
               onTap: (){
                 Navigator.of(context).push(MaterialPageRoute(builder: (context) => PatientDashboardScreen(),));
               },
             ),

            const PatientCard(
              name: "Sarah Williams",
              patientId: "PT-2024-1548",
              status: "Critical",
              diagnosis: "Septic Shock",
              admissionDate: "Jan 30, 2026 (4 days)",
              hrValue: "115",
              tempValue: "38.5°",
              bpValue: "90/60",
              spo2Value: "92%",
            ),
          ],
        ),
      ),
    );
  }
}