import 'package:cortexia/core/di/dependency_injection.dart';
import 'package:cortexia/core/widgets/custom_elevated_button.dart';
import 'package:cortexia/core/widgets/custom_form_field.dart';
import 'package:cortexia/features/admission/presentation/controllers/admission_cubit.dart';
import 'package:cortexia/features/admission/presentation/widgets/admission_form_section_container.dart';
import 'package:cortexia/features/patient/presentation/ui/patient_list_screen.dart';
import 'package:cortexia/features/patient/presentation/widgets/form_section_container.dart';
import 'package:cortexia/features/patient/presentation/widgets/patient_id_header.dart';

// تأكد من استيراد ملف الـ CustomAppBar الجديد هنا
import 'package:cortexia/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:cortexia/core/themes/color_themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';


class NewPatientRegistrationScreen extends StatelessWidget {
  const NewPatientRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // استبدال الـ AppBar العادي بالـ CustomAppBar الخاص بك
      appBar: CustomAppBar(
        title: "New Patient Registration",
        subtitle: "Complete patient information",
        // الـ onBackPressed متعرف تلقائياً بـ Navigator.pop جوه الـ Widget
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // الـ Custom Patient ID Header
            const PatientIdHeader(patientId: "PT-2026-6271"),

            const SizedBox(height: 20),

            // قسم المعلومات الشخصية
            FormSectionContainer(
              title: "Personal Information",
              icon: Icons.person_add_alt_1_outlined,
              children: [
                const CustomTextFormField(
                  labelText: "Full Name *",
                  hintText: "Enter patient's full name",
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Expanded(
                      child: CustomTextFormField(
                        labelText: "Age *",
                        hintText: "Years",
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: CustomTextFormField(
                        labelText: "Gender *",
                        hintText: "Select",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const CustomTextFormField(
                  labelText: "Blood Type",
                  hintText: "Select blood type",
                ),
              ],
            ),

            // قسم تفاصيل الدخول
            BlocProvider(
              create: (context) => AdmissionCubit(GetIt.I.get()),
              child: AdmissionFormSectionContainer(),
            ),

            // قسم المعلومات الطبية
            FormSectionContainer(
              title: "Clinical Information",
              icon: Icons.medical_information_outlined,
              iconColor: AppColors.errorRed,
              children: [
                const CustomTextFormField(
                  labelText: "Chief Complaint",
                  hintText: "Describe the primary reason for admission",
                ),
                const SizedBox(height: 16),
                const CustomTextFormField(
                  labelText: "Initial Diagnosis / Impression",
                  hintText: "Preliminary diagnosis",
                ),
              ],
            ),

            const SizedBox(height: 10),

            // زر الـ Register Patient
            CustomElevatedButton(
              text: "Register Patient",
              onPressed: () {
                // ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(content: Text("Patient Registered Successfully!")),
                // );
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => PatientListScreen(),));
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}