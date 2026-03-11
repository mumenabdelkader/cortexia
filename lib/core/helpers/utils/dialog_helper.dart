import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Reusable Confirmation Dialog
/// Can be used for delete, logout, cancel actions, etc.
class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final Color confirmButtonColor;
  final Color? confirmTextColor;
  final bool isDangerous; // For destructive actions

  const ConfirmationDialog({
    super.key,
    required this.title,
    this.subtitle,
    this.icon = Icons.person_off_outlined,
    this.iconColor = const Color(0xFFFE9235),
    this.iconBackgroundColor = const Color(0xFFFFE8D1),
    required this.confirmText,
    this.cancelText = 'إلغاء',
    required this.onConfirm,
    this.onCancel,
    this.confirmButtonColor = const Color(0xFFFE9235),
    this.confirmTextColor,
    this.isDangerous = false,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.r),
      ),
      backgroundColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: iconBackgroundColor,
                border: Border.all(
                  color: iconColor,
                  width: 3.w,
                ),
              ),
              child: Icon(
                icon,
                size: 60.sp,
                color: iconColor,
              ),
            ),
            SizedBox(height: 32.h),

            // Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                height: 1.4,
              ),
            ),

            // Subtitle (optional)
            if (subtitle != null) ...[
              SizedBox(height: 12.h),
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
              ),
            ],

            SizedBox(height: 32.h),

            // Confirm Button
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  onConfirm();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: confirmButtonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  confirmText,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: confirmTextColor ?? Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),

            // Cancel Button
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                  onCancel?.call();
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey[300]!),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  cancelText,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Show the dialog
  static Future<void> show(
      BuildContext context, {
        required String title,
        String? subtitle,
        IconData icon = Icons.person_off_outlined,
        Color iconColor = const Color(0xFFFE9235),
        Color iconBackgroundColor = const Color(0xFFFFE8D1),
        required String confirmText,
        String cancelText = 'إلغاء',
        required VoidCallback onConfirm,
        VoidCallback? onCancel,
        Color confirmButtonColor = const Color(0xFFFE9235),
        Color? confirmTextColor,
        bool isDangerous = false,
      }) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => ConfirmationDialog(
        title: title,
        subtitle: subtitle,
        icon: icon,
        iconColor: iconColor,
        iconBackgroundColor: iconBackgroundColor,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: onConfirm,
        onCancel: onCancel,
        confirmButtonColor: confirmButtonColor,
        confirmTextColor: confirmTextColor,
        isDangerous: isDangerous,
      ),
    );
  }

  /// Pre-configured dialog for deleting account
  static Future<void> showDeleteAccount(
      BuildContext context, {
        required VoidCallback onConfirm,
      }) {
    return show(
      context,
      title: 'هل أنت متأكد انك تريد\nحذف حسابك؟',
      icon: Icons.person_off_outlined,
      iconColor: const Color(0xFFFE9235),
      iconBackgroundColor: const Color(0xFFFFE8D1),
      confirmText: 'حذف حسابي',
      onConfirm: onConfirm,
    );
  }

  /// Pre-configured dialog for logout
  static Future<void> showLogout(
      BuildContext context, {
        required VoidCallback onConfirm,
      }) {
    return show(
      context,
      title: 'هل أنت متأكد من\nتسجيل الخروج؟',
      icon: Icons.logout_outlined,
      iconColor: const Color(0xFFFE9235),
      iconBackgroundColor: const Color(0xFFFFE8D1),
      confirmText: 'تسجيل الخروج',
      onConfirm: onConfirm,
    );
  }

  /// Pre-configured dialog for deleting item
  static Future<void> showDeleteItem(
      BuildContext context, {
        required String itemName,
        required VoidCallback onConfirm,
      }) {
    return show(
      context,
      title: 'هل أنت متأكد من\nحذف $itemName؟',
      subtitle: 'لن تتمكن من استرجاع هذا العنصر',
      icon: Icons.delete_outline,
      iconColor: const Color(0xFFE53935),
      iconBackgroundColor: const Color(0xFFFFEBEE),
      confirmText: 'حذف',
      confirmButtonColor: const Color(0xFFE53935),
      onConfirm: onConfirm,
      isDangerous: true,
    );
  }

  /// Pre-configured dialog for canceling order
  static Future<void> showCancelOrder(
      BuildContext context, {
        required VoidCallback onConfirm,
      }) {
    return show(
      context,
      title: 'هل أنت متأكد من\nإلغاء الطلب؟',
      subtitle: 'سيتم إلغاء الطلب بشكل نهائي',
      icon: Icons.cancel_outlined,
      iconColor: const Color(0xFFE53935),
      iconBackgroundColor: const Color(0xFFFFEBEE),
      confirmText: 'إلغاء الطلب',
      confirmButtonColor: const Color(0xFFE53935),
      onConfirm: onConfirm,
      isDangerous: true,
    );
  }

  /// Pre-configured dialog for clearing cart
  static Future<void> showClearCart(
      BuildContext context, {
        required VoidCallback onConfirm,
      }) {
    return show(
      context,
      title: 'هل أنت متأكد من\nإفراغ السلة؟',
      subtitle: 'سيتم حذف جميع المنتجات من السلة',
      icon: Icons.shopping_cart_outlined,
      iconColor: const Color(0xFFFE9235),
      iconBackgroundColor: const Color(0xFFFFE8D1),
      confirmText: 'إفراغ السلة',
      onConfirm: onConfirm,
    );
  }

  /// Pre-configured dialog for saving changes
  static Future<void> showSaveChanges(
      BuildContext context, {
        required VoidCallback onConfirm,
        VoidCallback? onCancel,
      }) {
    return show(
      context,
      title: 'هل تريد حفظ التغييرات؟',
      subtitle: 'سيتم فقدان التغييرات إذا لم يتم الحفظ',
      icon: Icons.save_outlined,
      iconColor: const Color(0xFF2196F3),
      iconBackgroundColor: const Color(0xFFE3F2FD),
      confirmText: 'حفظ التغييرات',
      cancelText: 'عدم الحفظ',
      confirmButtonColor: const Color(0xFF2196F3),
      onConfirm: onConfirm,
      onCancel: onCancel,
    );
  }

  /// Pre-configured dialog for confirmation
  static Future<void> showConfirmation(
      BuildContext context, {
        required String title,
        String? subtitle,
        required VoidCallback onConfirm,
      }) {
    return show(
      context,
      title: title,
      subtitle: subtitle,
      icon: Icons.check_circle_outline,
      iconColor: const Color(0xFF1DBF73),
      iconBackgroundColor: const Color(0xFFE8F5E9),
      confirmText: 'تأكيد',
      confirmButtonColor: const Color(0xFF1DBF73),
      onConfirm: onConfirm,
    );
  }

  /// Pre-configured dialog for warning
  static Future<void> showWarning(
      BuildContext context, {
        required String title,
        String? subtitle,
        required String confirmText,
        required VoidCallback onConfirm,
      }) {
    return show(
      context,
      title: title,
      subtitle: subtitle,
      icon: Icons.warning_amber_outlined,
      iconColor: const Color(0xFFFFA726),
      iconBackgroundColor: const Color(0xFFFFF3E0),
      confirmText: confirmText,
      confirmButtonColor: const Color(0xFFFFA726),
      onConfirm: onConfirm,
    );
  }
}

/// Dialog for stopping the application
/// Sends reason and duration notification to all users
class StopApplicationDialog extends StatefulWidget {
  final VoidCallback onConfirm;

  const StopApplicationDialog({
    super.key,
    required this.onConfirm,
  });

  /// Show the dialog
  static Future<void> show(
      BuildContext context, {
        required VoidCallback onConfirm,
      }) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => StopApplicationDialog(
        onConfirm: onConfirm,
      ),
    );
  }

  @override
  State<StopApplicationDialog> createState() => _StopApplicationDialogState();
}

class _StopApplicationDialogState extends State<StopApplicationDialog> {
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.r),
      ),
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Close Button
              Align(
                alignment: AlignmentDirectional.topStart,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: EdgeInsets.all(4.w),
                    child: Icon(
                      Icons.close,
                      size: 20.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h),

              // Title
              Text(
                'هل أنت متأكد من إيقاف التطبيق؟',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 24.h),

              // Reason TextField
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'سبب الإيقاف',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextField(
                    controller: _reasonController,
                    textAlign: TextAlign.right,
                    maxLines: 3,
                    style: TextStyle(fontSize: 14.sp),
                    decoration: InputDecoration(
                      hintText: 'سبب الإيقاف',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 13.sp,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: const BorderSide(
                          color: Color(0xFFFE9235),
                          width: 1.5,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 12.h,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Duration TextField
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'مدة الإيقاف',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextField(
                    controller: _durationController,
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 14.sp),
                    decoration: InputDecoration(
                      hintText: 'مدة الإيقاف',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 13.sp,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: const BorderSide(
                          color: Color(0xFFFE9235),
                          width: 1.5,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 12.h,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              // Confirm Button
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: () {
                    if (_reasonController.text.isEmpty ||
                        _durationController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'يرجى ملء جميع الحقول',
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                      );
                      return;
                    }

                    Navigator.pop(context);
                    widget.onConfirm();

                    // Here you would send the notification with reason and duration
                    // Example: sendNotificationToAllUsers(_reasonController.text, _durationController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFE9235),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'إيقاف التطبيق',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.h),

              // Cancel Button
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey[300]!, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    'إلغاء',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}