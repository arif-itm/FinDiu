import 'package:flutter/services.dart';

class InputValidators {
  // Input formatter for monetary amounts (allows decimal numbers)
  static List<TextInputFormatter> getAmountFormatters() {
    return [
      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
      LengthLimitingTextInputFormatter(10),
    ];
  }

  // Input formatter for student IDs (digits only)
  static List<TextInputFormatter> getStudentIdFormatters() {
    return [
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(15),
    ];
  }

  // Input formatter for phone numbers
  static List<TextInputFormatter> getPhoneFormatters() {
    return [
      FilteringTextInputFormatter.allow(RegExp(r'[0-9+\-\s()]')),
      LengthLimitingTextInputFormatter(20),
    ];
  }

  // Validate if amount string is valid
  static bool isValidAmount(String amount) {
    if (amount.isEmpty) return false;
    final parsed = double.tryParse(amount);
    return parsed != null && parsed > 0;
  }

  // Validate if student ID is valid
  static bool isValidStudentId(String studentId) {
    if (studentId.isEmpty) return false;
    return RegExp(r'^[0-9]+$').hasMatch(studentId) && studentId.length >= 4;
  }

  // Validate if phone number is valid (basic validation)
  static bool isValidPhone(String phone) {
    if (phone.isEmpty) return false;
    final cleanPhone = phone.replaceAll(RegExp(r'[^0-9+]'), '');
    return cleanPhone.length >= 10;
  }

  // Get error message for amount validation
  static String? getAmountErrorMessage(String amount) {
    if (amount.isEmpty) return null;
    if (!isValidAmount(amount)) {
      return 'Please enter a valid amount';
    }
    return null;
  }

  // Get error message for student ID validation
  static String? getStudentIdErrorMessage(String studentId) {
    if (studentId.isEmpty) return null;
    if (!isValidStudentId(studentId)) {
      return 'Please enter a valid student ID';
    }
    return null;
  }

  // Validate if email has the correct DIU domain
  static bool isValidDiuEmail(String email) {
    if (email.isEmpty) return false;
    return email.toLowerCase().endsWith('@diu.edu.bd') && 
           email.contains('@') && 
           email.indexOf('@') > 0;
  }

  // Get error message for email validation
  static String? getDiuEmailErrorMessage(String email) {
    if (email.isEmpty) return null;
    if (!email.contains('@')) {
      return 'Please enter a valid email address';
    }
    if (!email.toLowerCase().endsWith('@diu.edu.bd')) {
      return 'Please use your DIU email address (@diu.edu.bd)';
    }
    if (email.indexOf('@') == 0) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  // Input formatter for email (allows alphanumeric, dots, hyphens, and @ symbol)
  static List<TextInputFormatter> getEmailFormatters() {
    return [
      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@.\-_]')),
      LengthLimitingTextInputFormatter(50),
    ];
  }
}
