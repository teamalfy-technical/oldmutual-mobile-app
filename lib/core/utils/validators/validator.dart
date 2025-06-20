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
        Get.put(PContributionHistoryVm()).summmary.value.currentValue ?? 0;
    if (number > totalAmount) {
      // Replace 100 with your desired max value
      return 'Amount cannot be greater than ${PFormatter.formatCurrency(amount: totalAmount)}';
    }

    return null;
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
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    final phoneRegExp = RegExp(r'^\d{10}$');
    if (!emailRegExp.hasMatch(value) && !phoneRegExp.hasMatch(value)) {
      return 'Invalid email or phone number';
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

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }

    if (!value.contains(RegExp(r'[A-Z]')) &&
        !value.contains(RegExp(r'[0-9]')) &&
        !value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Not strong enough';
    }

    // check for minimum password length
    if (value.length < 8) {
      return 'Password must be at least 8 characters long.';
    }

    // check of uppercase letters
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter.';
    }

    // check of number
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number.';
    }

    // check of special characters
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password much contain at least one special character.';
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

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required.';
    }

    // RegExp for phone number validation (e.g., a 10-digit us phone number format)
    final phoneRegExp = RegExp(r'^\d{10}$');

    // check of special characters
    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid phone number format (10 digits required).';
    }

    return null;
  }

  // Add more here as need for your requirements
}
