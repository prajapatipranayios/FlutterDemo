// lib/app/utils/date_utils.dart

class DateUtilsHelper {
  /// Generates Coded PIN
  /// YYMMDDW  →  e.g. 2509114
  static String generateCodedPin([DateTime? date]) {
    final d = date ?? DateTime.now();

    String yy = d.year.toString().substring(2);          // 2-digit year
    String mm = d.month.toString().padLeft(2, '0');      // 2-digit month
    String dd = d.day.toString().padLeft(2, '0');        // 2-digit day
    int weekday = d.weekday;                             // Mon=1 ... Sun=7

    return "$yy$mm$dd$weekday";
  }
}
