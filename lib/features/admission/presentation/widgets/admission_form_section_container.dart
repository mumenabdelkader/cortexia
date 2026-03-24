import 'package:cortexia/core/widgets/custom_elevated_button.dart';
import 'package:cortexia/core/widgets/custom_form_field.dart';
import 'package:cortexia/features/admission/presentation/controllers/admission_cubit.dart';
import 'package:cortexia/features/admission/presentation/controllers/admission_state.dart';
import 'package:cortexia/features/patient/presentation/widgets/form_section_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdmissionFormSectionContainer extends StatefulWidget {
  final String? patientId;
  final String? doctorId;
  const AdmissionFormSectionContainer({super.key, this.patientId, this.doctorId});

  @override
  State<AdmissionFormSectionContainer> createState() => _AdmissionFormSectionContainerState();
}

class _AdmissionFormSectionContainerState extends State<AdmissionFormSectionContainer> {
  // تعريف الـ Controllers هنا لضمان عدم إعادة إنشائها مع كل Build
  late TextEditingController initialDiagnosisController;
  late TextEditingController roomIdController;
  late TextEditingController bedIdController;
  final String admissionDate = DateTime.now().toUtc().toIso8601String().split('.').first + 'Z';

  @override
  void initState() {
    super.initState();
    initialDiagnosisController = TextEditingController();
    roomIdController = TextEditingController();
    bedIdController = TextEditingController();
  }

  @override
  void dispose() {
    // تنظيف الذاكرة عند إغلاق الشاشة
    initialDiagnosisController.dispose();
    roomIdController.dispose();
    bedIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdmissionCubit, AdmissionState>(
      listener: (context, state) {
        if (state is AdmissionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Admission saved successfully!"),
              backgroundColor: Colors.green,
            ),
          );
          // يمكنك هنا إضافة Navigation لو حابب تخرج من الصفحة بعد النجاح
        } else if (state is AdmissionError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return FormSectionContainer(
          title: "Admission Details",
          icon: Icons.login_outlined,
          iconColor: Colors.teal,
          children: [
            CustomTextFormField(
              labelText: "Initial Diagnosis *",
              hintText: "Enter diagnosis",
              prefixIcon: Icons.medical_services_outlined,
              controller: initialDiagnosisController,
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              labelText: "Room ID",
              hintText: "ROM-0ED2FF98CFFE",
              controller: roomIdController,
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              labelText: "Bed ID",
              hintText: "BED-B3BE37F61944",
              controller: bedIdController,
            ),
            const SizedBox(height: 24),

            // التحقق من حالة اللودنج لتغيير شكل الزرار
            state is AdmissionLoading
                ? const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(color: Colors.teal),
              ),
            )
                : CustomElevatedButton(
              text: "Save Admission",
              onPressed: () {
                // التأكد من أن البيانات ليست فارغة قبل الإرسال (اختياري)
                if (initialDiagnosisController.text.isNotEmpty) {
                  context.read<AdmissionCubit>().createAdmission(
                    patientId: widget.patientId ?? "PAT-FA20DCEE31AE", // Fallback to old for safety if needed, or remove
                    doctorId: widget.doctorId ?? "DOC-1436C0633BBD",
                    admissionDate: admissionDate,
                    initialDiagnosis: initialDiagnosisController.text,
                    roomId: roomIdController.text,
                    bedId: bedIdController.text,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please fill required fields")),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}