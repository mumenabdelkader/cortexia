import 'package:flutter/material.dart';
import 'package:cortexia/core/themes/app_dimens.dart';
import 'package:cortexia/core/themes/color_themes.dart';
import 'package:cortexia/core/widgets/custom_app_bar.dart';
import 'package:cortexia/core/widgets/custom_elevated_button.dart';
import 'package:cortexia/core/widgets/custom_form_field.dart';

class ClinicalNotesScreen extends StatelessWidget {
  const ClinicalNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: const CustomAppBar(title: 'Clinical Notes'),
      body: SingleChildScrollView(
        padding: AppDimens.paddingAll16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryCard(),
            SizedBox(height: AppDimens.space16),
            _buildCategoryFilters(),
            SizedBox(height: AppDimens.space16),
            _buildAddNewNoteSection(context),
            SizedBox(height: AppDimens.space24),
            Text(
              'Timeline',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.textMain,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: AppDimens.space16),
            _buildTimelineList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      padding: AppDimens.paddingAll16,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppDimens.radius16,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: AppDimens.paddingAll12,
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.note_alt_outlined, color: AppColors.primaryBlue),
              ),
              SizedBox(width: AppDimens.space12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '5',
                    style: TextStyle(
                      fontSize: AppDimens.fontTitle,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  Text(
                    'Total Notes',
                    style: TextStyle(
                      fontSize: AppDimens.fontMedium,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Last Updated',
                style: TextStyle(
                  fontSize: AppDimens.fontSmall,
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: AppDimens.space4),
              Text(
                'Today, 08:30 AM',
                style: TextStyle(
                  fontSize: AppDimens.fontMedium,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textMain,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilters() {
    final categories = ['All Notes', 'Progress', 'Nursing', 'Consultations'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(categories.length, (index) {
          final isSelected = index == 0;
          return Padding(
            padding: EdgeInsets.only(right: AppDimens.space8),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: AppDimens.space16, vertical: AppDimens.space8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryBlue : AppColors.white,
                borderRadius: AppDimens.radius8,
                border: Border.all(
                  color: isSelected ? AppColors.primaryBlue : AppColors.border,
                ),
              ),
              child: Text(
                categories[index],
                style: TextStyle(
                  color: isSelected ? AppColors.white : AppColors.textMain,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildAddNewNoteSection(BuildContext context) {
    return Container(
      padding: AppDimens.paddingAll16,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppDimens.radius16,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.add_circle_outline, color: AppColors.primaryBlue),
              SizedBox(width: AppDimens.space8),
              Text(
                'Add New Note',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.textMain,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          SizedBox(height: AppDimens.space12),
          const CustomTextFormField(
            hintText: 'Type your clinical note here...',
          ),
          SizedBox(height: AppDimens.space16),
          Row(
            children: [
              Expanded(
                child: CustomElevatedButton(
                  text: 'Save Note',
                  onPressed: () {},
                  height: AppDimens.buttonHeight,
                  backgroundColor: AppColors.primaryBlue,
                  textColor: AppColors.white,
                ),
              ),
              SizedBox(width: AppDimens.space12),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: AppDimens.radius8,
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: AppDimens.radius8,
                      onTap: () {},
                      child: Container(
                        height: AppDimens.buttonHeight,
                        alignment: Alignment.center,
                        child: const Text(
                          'Voice Input',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineList() {
    return Column(
      children: [
        _buildTimelineCard(
          authorName: 'Dr. Sarah Johnson',
          authorRole: 'Attending Physician',
          tag: 'Progress Note',
          tagColor: AppColors.warningOrange,
          date: 'Feb 3, 2026 • 08:30 AM',
          content:
              'Patient showing improvement. Fever subsiding, WBC trending down. Breath sounds improved bilaterally. Continue current antibiotics. Plan to repeat chest X-ray in 48 hours. Patient tolerated PO intake well.',
          categories: ['Progress', 'Clinical Assessment'],
        ),
        SizedBox(height: AppDimens.space16),
        _buildTimelineCard(
          authorName: 'Nurse Emily Carter',
          authorRole: 'ICU Nurse',
          tag: 'Nursing Note',
          tagColor: AppColors.successGreen,
          date: 'Feb 3, 2026 • 06:00 AM',
          content:
              'Night shift uneventful. Patient rested well. Vital signs stable throughout the night. IV site clean and patent. No complaints of pain or discomfort. Morning medications administered as ordered.',
          categories: ['Nursing', 'Night Shift'],
        ),
      ],
    );
  }

  Widget _buildTimelineCard({
    required String authorName,
    required String authorRole,
    required String tag,
    required Color tagColor,
    required String date,
    required String content,
    required List<String> categories,
  }) {
    return Container(
      padding: AppDimens.paddingAll16,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppDimens.radius16,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
                child: const Icon(Icons.person, color: AppColors.primaryBlue),
              ),
              SizedBox(width: AppDimens.space12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      authorName,
                      style: TextStyle(
                        fontSize: AppDimens.fontLarge,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textMain,
                      ),
                    ),
                    Text(
                      authorRole,
                      style: TextStyle(
                        fontSize: AppDimens.fontSmall,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: AppDimens.space8, vertical: AppDimens.space4),
                decoration: BoxDecoration(
                  color: tagColor.withOpacity(0.1),
                  borderRadius: AppDimens.radius8,
                  border: Border.all(color: tagColor),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    fontSize: AppDimens.fontSmall,
                    color: tagColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimens.space8),
          Row(
            children: [
              Icon(Icons.access_time, size: AppDimens.fontSmall, color: AppColors.textSecondary),
              SizedBox(width: AppDimens.space4),
              Text(
                date,
                style: TextStyle(
                  fontSize: AppDimens.fontSmall,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimens.space12),
          Text(
            content,
            style: TextStyle(
              fontSize: AppDimens.fontMedium,
              color: AppColors.textMain,
              height: 1.5,
            ),
          ),
          SizedBox(height: AppDimens.space12),
          Wrap(
            spacing: AppDimens.space8,
            runSpacing: AppDimens.space8,
            children: categories.map((cat) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: AppDimens.space12, vertical: AppDimens.space4),
                decoration: BoxDecoration(
                  color: AppColors.scaffoldBg,
                  borderRadius: AppDimens.radius8,
                  border: Border.all(color: AppColors.border),
                ),
                child: Text(
                  cat,
                  style: TextStyle(
                    fontSize: AppDimens.fontSmall,
                    color: AppColors.textSecondary,
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: AppDimens.space16),
          const Divider(color: AppColors.divider),
          SizedBox(height: AppDimens.space8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildActionBtn(Icons.visibility_outlined, 'View Full'),
              _buildActionBtn(Icons.edit_outlined, 'Edit'),
              _buildActionBtn(Icons.print_outlined, 'Print'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionBtn(IconData icon, String label) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          Icon(icon, size: AppDimens.fontLarge, color: AppColors.textSecondary),
          SizedBox(width: AppDimens.space4),
          Text(
            label,
            style: TextStyle(
              fontSize: AppDimens.fontMedium,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
