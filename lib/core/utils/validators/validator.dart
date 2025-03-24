class PValidator {
  PValidator._();

  static String? validateText(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field cannot be empty.';
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
    final phoneRegExp = RegExp(r'^\d{12}$');

    // check of special characters
    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid phone number format (12 digits required).';
    }

    return null;
  }

  // Add more here as need for your requirements
}
