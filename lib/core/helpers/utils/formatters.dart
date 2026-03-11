import 'package:intl/intl.dart';

class Formatters {
  Formatters._();

  /// Format price with currency
  static String formatPrice(double price, {String currency = 'ج.م'}) {
    final formatter = NumberFormat('#,##0.00', 'ar_EG');
    return '${formatter.format(price)} $currency';
  }

  /// Format number with commas
  static String formatNumber(int number) {
    final formatter = NumberFormat('#,###', 'ar_EG');
    return formatter.format(number);
  }

  /// Format date
  static String formatDate(DateTime date, {String format = 'yyyy/MM/dd'}) {
    final formatter = DateFormat(format, 'ar_EG');
    return formatter.format(date);
  }

  /// Format time ago (منذ 5 دقائق)
  static String formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return 'منذ $years ${years == 1 ? 'سنة' : 'سنوات'}';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return 'منذ $months ${months == 1 ? 'شهر' : 'أشهر'}';
    } else if (difference.inDays > 0) {
      return 'منذ ${difference.inDays} ${difference.inDays == 1 ? 'يوم' : 'أيام'}';
    } else if (difference.inHours > 0) {
      return 'منذ ${difference.inHours} ${difference.inHours == 1 ? 'ساعة' : 'ساعات'}';
    } else if (difference.inMinutes > 0) {
      return 'منذ ${difference.inMinutes} ${difference.inMinutes == 1 ? 'دقيقة' : 'دقائق'}';
    } else {
      return 'الآن';
    }
  }

  /// Truncate text with ellipsis
  static String truncate(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }
}
