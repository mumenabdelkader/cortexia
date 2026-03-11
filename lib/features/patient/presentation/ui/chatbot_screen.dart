import 'package:cortexia/core/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:cortexia/core/widgets/custom_app_bar.dart';

class ChatbotScreen extends StatelessWidget {
  const ChatbotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // 1. استخدام الـ CustomAppBar الموحد للمشروع
      appBar: const CustomAppBar(
        title: "Chatbot AI",
        subtitle: "ID:PT-2026-1564",
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  // 2. صورة الروبوت المركزية كما في Figma
                  Center(
                    child: Image.asset(
                      'assets/images/ai.png',
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 30),
                  // 3. فقاعة الترحيب الرمادية
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.auto_awesome, color: Colors.blue, size: 20),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Hi, you can ask me anything about patient health or records.",
                            style: TextStyle(
                              color: Color(0xFF475569),
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 4. منطقة الإدخال السفلية المحدثة
          _buildChatInput(context),
        ],
      ),
    );
  }

  // ميثود بناء حقل الإدخال السفلي باستخدام CustomTextFormField المحدث
  Widget _buildChatInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha:0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              // استخدام النسخة المحدثة من الكلاس التي تدعم suffixIcon
              child: CustomTextFormField(
                hintText: "Generate a name of ....",
                fillColor: const Color(0xFFF8FAFC),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.attach_file, color: Color(0xFF94A3B8), size: 20),
                  onPressed: () {
                    // منطق إرفاق الملفات
                  },
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // زر الإرسال الدائري الأزرق متناسق مع ارتفاع الحقل
          Container(
            height: 50, // متناسق مع ارتفاع TextFormField الافتراضي
            width: 50,
            decoration: const BoxDecoration(
              color: Color(0xFF0052CC),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white, size: 22),
              onPressed: () {
                // منطق الإرسال
              },
            ),
          ),
        ],
      ),
    );
  }
}