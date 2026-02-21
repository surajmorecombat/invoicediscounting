import 'package:flutter/material.dart';

class CommonValidators {
  /// Validates that the field is not empty
  static String? requiredValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  /// Validates email format
  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  /// Validates phone number (Indian format)
  static String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    final phoneRegex = RegExp(r'^[0-9]{10}$');
    if (!phoneRegex.hasMatch(value.replaceAll(RegExp(r'[^0-9]'), ''))) {
      return 'Please enter a valid 10-digit phone number';
    }
    return null;
  }

 
  static String? emailOrPhoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email or phone number is required';
    }
    
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    final phoneRegex = RegExp(r'^[0-9]{10}$');
    
    final cleanPhone = value.replaceAll(RegExp(r'[^0-9]'), '');
    
    if (emailRegex.hasMatch(value) || phoneRegex.hasMatch(cleanPhone)) {
      return null;
    }
    
    return 'Please enter a valid email or 10-digit phone number';
  }

 
  static String? panValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'PAN is required';
    }
    final pan = value.trim().toUpperCase();
    final panRegex = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$');
    if (!panRegex.hasMatch(pan)) {
      return 'Please enter a valid PAN (e.g. ABCDE1234F)';
    }
    return null;
  }

  static String? aadhaarValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Aadhaar is required';
    }
    final digitsOnly = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (digitsOnly.length != 12) {
      return 'Aadhaar must be 12 digits';
    }
    if (!_isValidVerhoeff(digitsOnly)) {
      return 'Please enter a valid Aadhaar number';
    }
    return null;
  }


  static String? minLengthValidator(String? value, int minLength) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    if (value.length < minLength) {
      return 'Must be at least $minLength characters';
    }
    return null;
  }

  static bool _isValidVerhoeff(String num) {
    final d = [
      [0,1,2,3,4,5,6,7,8,9],
      [1,2,3,4,0,6,7,8,9,5],
      [2,3,4,0,1,7,8,9,5,6],
      [3,4,0,1,2,8,9,5,6,7],
      [4,0,1,2,3,9,5,6,7,8],
      [5,9,8,7,6,0,4,3,2,1],
      [6,5,9,8,7,1,0,4,3,2],
      [7,6,5,9,8,2,1,0,4,3],
      [8,7,6,5,9,3,2,1,0,4],
      [9,8,7,6,5,4,3,2,1,0]
    ];

    final p = [
      [0,1,2,3,4,5,6,7,8,9],
      [1,5,7,6,2,8,3,0,9,4],
      [5,8,0,3,7,9,6,1,4,2],
      [8,9,1,6,0,4,3,5,2,7],
      [9,4,5,3,1,2,6,8,7,0],
      [4,2,8,6,5,7,3,9,0,1],
      [2,7,9,3,8,0,6,4,1,5],
      [7,0,4,6,9,1,3,2,5,8]
    ];

    int c = 0;
    for (int i = 0; i < num.length; i++) {
      final int digit = int.parse(num[num.length - 1 - i]);
      c = d[c][p[i % 8][digit]];
    }
    return c == 0;
  }

 
  static String? maxLengthValidator(String? value, int maxLength) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    if (value.length > maxLength) {
      return 'Must not exceed $maxLength characters';
    }
    return null;
  }


  static String? compositeValidator(String? value, List<FormFieldValidator<String>> validators) {
    for (var validator in validators) {
      final result = validator(value);
      if (result != null) {
        return result;
      }
    }
    return null;
  }
}
