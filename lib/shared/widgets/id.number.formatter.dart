import 'package:flutter/services.dart';

class IdNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove any existing hyphen
    String digitsOnly = newValue.text.replaceAll('-', '');

    // Limit to max 10 digits (before adding hyphen)
    if (digitsOnly.length > 10) {
      digitsOnly = digitsOnly.substring(0, 10);
    }

    String formatted = digitsOnly;

    // Insert hyphen after 9th digit if available
    if (digitsOnly.length > 9) {
      formatted = digitsOnly.substring(0, 9) + '-' + digitsOnly.substring(9);
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
