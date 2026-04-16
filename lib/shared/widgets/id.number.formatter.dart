import 'package:flutter/services.dart';

class IdNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove any existing hyphens
    String cleaned = newValue.text.replaceAll('-', '').toUpperCase();

    // Limit to max 13 characters (GHA + 9 digits + 1 digit = 13 without hyphens)
    if (cleaned.length > 13) {
      cleaned = cleaned.substring(0, 13);
    }

    String formatted = cleaned;

    // Insert hyphen after prefix (3 chars) and after 9 digits
    if (cleaned.length > 3) {
      formatted = '${cleaned.substring(0, 3)}-${cleaned.substring(3)}';
    }
    if (cleaned.length > 12) {
      formatted =
          '${cleaned.substring(0, 3)}-${cleaned.substring(3, 12)}-${cleaned.substring(12)}';
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class MaxAmountFormatter extends TextInputFormatter {
  MaxAmountFormatter(this.maxAmount);

  final double Function() maxAmount;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return newValue;
    final parsed = double.tryParse(newValue.text);
    if (parsed == null) return oldValue;
    return parsed > maxAmount() ? oldValue : newValue;
  }
}
