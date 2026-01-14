import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oldmutual_pensions_app/core/utils/formatters/formatters.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/contribution.history.dart';

class PValidator {
  PValidator._();

  static String? validateText(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field cannot be empty.';
    }

    return null;
  }

  // PSecureStorage().getAuthResponse()!.schemeType!.contains('TIER 2')

  static String? validateSchemeAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field cannot be empty.';
    }

    final number = double.tryParse(value);
    if (number == null) {
      return 'Please enter a valid number';
    }

    final totalAmount =
        Get.put(PContributionHistoryVm()).summary.value.currentValue ?? 0;
    if (number > totalAmount) {
      // Replace 100 with your desired max value
      return 'Amount cannot be greater than ${PFormatter.formatCurrency(amount: totalAmount)}';
    }

    return null;
  }

  String? normalizeAndValidatePhoneNumber(String input) {
    // Remove spaces and any non-digit characters
    String cleaned = input.replaceAll(RegExp(r'\D'), '');

    // If number starts with "0", replace with "233"
    if (cleaned.startsWith('0')) {
      cleaned = '233${cleaned.substring(1)}';
    }
    // If already starts with "233", keep as is
    else if (!cleaned.startsWith('233')) {
      // If it doesn’t start with 0 or 233, assume Ghana and prefix "233"
      cleaned = '233$cleaned';
    }

    // ✅ Validate length (must be exactly 12 digits: 233 + 9 digits)
    if (cleaned.length != 12) {
      return null; // invalid number
    }

    return cleaned;
  }

  static String? validatePercentage(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field cannot be empty.';
    }

    final number = double.tryParse(value);
    if (number == null) {
      return 'Please enter a valid number';
    }

    if (number > 100) {
      return 'Percentage cannot be greater than 100';
    }

    return null;
  }

  static String? validateDelete(value) {
    if (value == null || value.isEmpty) {
      return "Please type DELETE to proceed";
    }
    if (value.trim() != "DELETE") {
      return "You must type DELETE to proceed";
    }
    return null; // valid input
  }

  static String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a date';
    }
    try {
      DateFormat('dd-MM-yyyy').parseStrict(value);
    } catch (_) {
      return 'Invalid date format';
    }
    return null;
  }

  static String? validateEmailOrPhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email or phone cannot be empty.';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    final phoneRegex = RegExp(r'^\d{9,10}$');
    if (!emailRegex.hasMatch(value) && !phoneRegex.hasMatch(value)) {
      return 'Enter a valid email or phone number';
    }

    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }

    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address';
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String? password) {
    if (value!.isEmpty) {
      return 'Confirm password is required';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }

    // check for minimum password length
    if (value.length < 8) {
      return 'Must be at least 8 characters long.';
    }

    // check of uppercase letters
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Must contain at least one uppercase letter.';
    }

    // check of number
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Must contain at least one number.';
    }

    // check of special characters
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Must contain at least one special character.';
    }

    return null;
  }

  // validate if password is strong enough
  static bool isPasswordStrong(String? value) {
    bool strong = false;

    // check of uppercase letters
    if (value!.length >= 8 &&
        value.contains(RegExp(r'[A-Z]')) &&
        value.contains(RegExp(r'[0-9]')) &&
        value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      strong = true;
    }

    return strong;
  }

  // validate if password length is valid
  static bool isPasswordValid(String? value) {
    bool valid = false;

    // check of uppercase letters
    if (value!.length >= 8) {
      valid = true;
    }

    return valid;
  }

  static String? validateIdNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "ID number is required";
    }

    // Pattern: GHA or ZWE prefix, 9 digits, hyphen, 1 digit
    final regex = RegExp(r'^(GHA|ZWE)-\d{9}-\d{1}$');

    if (!regex.hasMatch(value)) {
      return "Enter a valid ID (e.g. GHA-234445555-5)";
    }

    return null; // valid
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required.';
    }

    // RegExp for phone number validation (e.g., a 10-digit us phone number format)

    final phoneRegex = RegExp(r'^\d{9,10}$');

    // check of special characters
    if (!phoneRegex.hasMatch(value)) {
      return 'Invalid phone number format (9 or 10 digits required).';
    }

    return null;
  }

  // Add more here as need for your requirements

  static bool validatePasswordLength(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }

    if (value.length < 8 || value.length > 16) {
      return false;
    }

    if (value.contains(' ')) {
      return false;
    }

    return true; // ✅ valid
  }

  static bool validatePasswordCapital(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return false;
    }

    return true; // ✅ valid
  }

  static bool validatePasswordSpecialAndNumber(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }

    // At least one number
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return false;
    }

    // At least one special character (!@#$&*~)
    if (!RegExp(r'[!@#\$&*~]').hasMatch(value)) {
      return false;
    }

    return true; // ✅ valid
  }
}
