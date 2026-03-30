import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PFormatter {
  PFormatter._();

  /// --- format date
  static String formatDate({required DateFormat dateFormat, DateTime? date}) {
    date ??= DateTime.now();
    return dateFormat.format(date);
  }

  /// --- format date
  static String formatDateStrict({
    required DateFormat dateFormat,
    String? date,
  }) {
    date ??= DateTime.now().toString();
    final parsedDate = dateFormat.parseStrict(date);
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(parsedDate);
  }

  static String formatAlertDateTime(DateTime date) {
    final datePart = DateFormat('d MMM yyyy').format(date); // e.g., 24 Feb 2023
    final timePart = DateFormat('HH:mm').format(date); // e.g., 13:56
    return '$datePart • $timePart';
  }

  static String formatPhone({required String code, required String phone}) {
    var formatted = phone.startsWith('0') ? phone.substring(1) : phone;
    return '$code$formatted';
  }

  /// --- format time
  static String formatTime({DateTime? date, DateFormat? dateFormat}) {
    date ??= DateTime.now();
    final dtFormat = dateFormat ?? DateFormat.jmv();
    return dtFormat.format(date);
  }

  /// --- calculate difference between two dates (In Days)
  static int calculateDateDiff(String date, DateDiffUnit unit) {
    final parseDate = DateTime.parse(date);
    final now = DateTime.now();

    switch (unit) {
      case DateDiffUnit.days:
        return now.difference(parseDate).inDays.abs();

      case DateDiffUnit.months:
        int months =
            (now.year - parseDate.year) * 12 + (now.month - parseDate.month);
        if (now.day < parseDate.day) {
          months--; // adjust if day not reached yet
        }
        return months.abs();

      case DateDiffUnit.years:
        int years = now.year - parseDate.year;
        if (now.month < parseDate.month ||
            (now.month == parseDate.month && now.day < parseDate.day)) {
          years--; // adjust if birthday/anniversary not reached yet
        }
        return years.abs();
    }
  }

  /// --- calculate difference between two dates (In Years)
  // static int calculateDateDiff(String date) {
  //   final parseDate = DateTime.parse(date);
  //   final diff = DateTime.now().difference(parseDate);
  //   return diff.inDays;
  // }

  /// --- format currency
  // static String formatCurrency({required double amount, String symbol = '₵'}) {
  //   return NumberFormat.currency(
  //     locale: 'en_GH',
  //     symbol: symbol,
  //   ).format(amount);
  // }

  static String formatCurrency({
    required double amount,
    String? symbol = '₵',
    bool useSpaceSeparator = true,
  }) {
    // double value;
    // if (amount == null) {
    //   value = 0.0;
    // } else if (amount is num) {
    //   value = amount.toDouble();
    // } else {
    //   value = double.tryParse(amount.toString()) ?? 0.0;
    // }

    // Format with comma grouping and two decimals
    String formatted = NumberFormat("#,##0.00", "en_US").format(amount);

    // Replace commas with spaces if required
    if (useSpaceSeparator) {
      formatted = formatted.replaceAll(',', ' ');
    }

    // Add symbol if provided
    if (symbol != null && symbol.isNotEmpty) {
      return "$symbol$formatted";
    }

    return formatted;
  }

  static String formatMoneyValue(double value) {
    final formatter = NumberFormat(
      // '#,##0.00',
      '#,###',
      'en_GH',
    ); // 'en_GH' for Ghana locale

    // return '₵${formatter.format(value)}';
    if (value >= 1000000000) {
      // Format as Billion (₵1.0B)
      return 'GHS ${formatter.format(value / 1000000000)}B';
    } else if (value >= 1000000) {
      // Format as Million (₵700M)
      return 'GHS ${formatter.format(value / 1000000)}M';
    } else if (value >= 1000) {
      // Format as Thousand (₵700K)
      return 'GHS ${formatter.format(value / 1000)}K';
    } else {
      // For values less than 1000, just add the Cedi symbol
      return 'GHS ${formatter.format(value)}';
    }
    //GHS
  }

  static String convertToAgo(DateTime input) {
    Duration diff = DateTime.now().difference(input);

    if (diff.inDays > 1) {
      return '${diff.inDays} days ago';
    } else if (diff.inDays == 1) {
      return '${diff.inDays} day ago';
    } else if (diff.inHours > 1) {
      return '${diff.inHours} hours ago';
    } else if (diff.inHours == 1) {
      return '${diff.inHours} hour ago';
    } else if (diff.inMinutes > 1) {
      return '${diff.inMinutes} minutes ago';
    } else if (diff.inMinutes == 1) {
      return '${diff.inMinutes} minute ago';
    } else if (diff.inSeconds > 1) {
      return '${diff.inSeconds} seconds ago';
    } else if (diff.inSeconds == 1) {
      return '${diff.inSeconds} second ago';
    } else {
      return 'just now';
    }
  }
}

/// Custom formatter to insert '-' after dd and MM
class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text;

    // Remove any existing '-' first
    text = text.replaceAll('-', '');

    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      // Add - after day (2 digits) and after month (2 more digits)
      if ((i == 1 || i == 3) && i != text.length - 1) {
        buffer.write('-');
      }
    }

    final formattedText = buffer.toString();

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
