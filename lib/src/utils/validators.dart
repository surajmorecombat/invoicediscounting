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

  /// Validates email or phone number (either one is valid)
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


  static String? minLengthValidator(String? value, int minLength) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    if (value.length < minLength) {
      return 'Must be at least $minLength characters';
    }
    return null;
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
