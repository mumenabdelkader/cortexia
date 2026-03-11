import 'package:cortexia/features/authentication/presentation/ui/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:cortexia/core/themes/color_themes.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // البيانات الخاصة بالـ 3 صفحات
  final List<Map<String, String>> _welcomeData = [
    {
      "title": "Smart ICU Patient Monitoring",
      "subtitle": "Monitor ICU patients in real time with intelligent insights.",
      "image": "assets/images/Group.png", // حط مسار الصور بتاعتك هنا
    },
    {
      "title": "AI-Powered Clinical Support",
      "subtitle": "Get smart recommendations and alerts to support medical decisions.",
      "image": "assets/images/Group2.png",
    },
    {
      "title": "Designed for ICU Teams",
      "subtitle": "Fast, secure, and easy-to-use system for doctors and nurses.",
      "image": "assets/images/Group3.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _welcomeData.length,
                itemBuilder: (context, index) => _buildPageContent(
                  title: _welcomeData[index]["title"]!,
                  subtitle: _welcomeData[index]["subtitle"]!,
                  image: _welcomeData[index]["image"]!,
                ),
              ),
            ),

            // الجزء السفلي (Skip, Dots, Next Button)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // زر Skip
                  TextButton(
                    onPressed: () {
                      // أكشن التخطي (يروح للـ Login مثلاً)
                    },
                    child: Text(
                      "Skip",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  // الـ Dots (Indicators)
                  Row(
                    children: List.generate(
                      _welcomeData.length,
                          (index) => _buildDot(index),
                    ),
                  ),

                  // زر السهم (Next)
                  GestureDetector(
                    onTap: () {
                      if (_currentPage < _welcomeData.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      } else {
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginScreen()));
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: AppColors.primaryBlue,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ويدجت محتوى الصفحة
  Widget _buildPageContent({required String title, required String subtitle, required String image}) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // الصورة
          // استبدل Image.asset بـ Placeholder لو لسه معندكش الصور
          Expanded(
            child: Image.asset(
              image,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.image, size: 100, color: AppColors.primaryBlue),
            ),
          ),
          const SizedBox(height: 40),
          // العنوان
          Text(
            title,
            textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayLarge,
          ),
          const SizedBox(height: 16),
          // النص الفرعي
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }

  // ويدجت النقاط (Indicator Dots)
  Widget _buildDot(int index) {
    return Container(
      height: 8,
      width: _currentPage == index ? 12 : 8,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index ? AppColors.primaryBlue : AppColors.border,
      ),
    );
  }
}