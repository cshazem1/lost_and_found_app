
import '../../generated/l10n.dart';

class Validation {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.enterYourName;
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.enterYourEmail;
    }
    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    if (!emailRegex.hasMatch(value)) {
      return S.current.invalidEmail;
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.enterYourPassword;
    }
    if (value.length < 8) {
      return S.current.passwordTooShort;
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return S.current.passwordMustContainUppercase;
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return S.current.passwordMustContainLowercase;
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return S.current.passwordMustContainDigit;
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return S.current.passwordMustContainSpecialChar;
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String? originalPassword) {
    if (value == null || value.isEmpty) {
      return S.current.enterYourConfirmPassword;
    }
    if (value != originalPassword) {
      return S.current.passwordsDoNotMatch;
    }
    return null;
  }
}
