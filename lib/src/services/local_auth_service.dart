import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';


class LocalAuthService {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> canAuthenticate() async {
    return await _auth.isDeviceSupported();
  }

  Future<bool> authenticate({required String reason}) async {
    try {
      return await _auth.authenticate(
        localizedReason: reason,
        biometricOnly: false,
        persistAcrossBackgrounding: true,
      );
    } on LocalAuthException catch (e) {
      
      debugPrint('LocalAuth error code: ${e.code}');
      debugPrint('LocalAuth error message: ${e.description}');

      return false;
    }
  }
}

final authService = LocalAuthService();

void authenticateUser() async {
  final canAuth = await authService.canAuthenticate();
  if (!canAuth) return;

  final success = await authService.authenticate(
    reason: 'Authenticate to access your portfolio',
  );

  if (success) {
  } else {}
}
