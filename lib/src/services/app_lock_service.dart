import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/services/local_auth_service.dart';

class AppLockService with WidgetsBindingObserver {
  final LocalAuthService _authService = LocalAuthService();

  DateTime _lastActive = DateTime.now();
  bool _isAuthenticating = false;

  void markActive() {
    _lastActive = DateTime.now();
  }

  bool get needsReauth => DateTime.now().difference(_lastActive).inMinutes >= 2;

  Future<void> handleResume(BuildContext context) async {
    if (_isAuthenticating || !needsReauth) return;

    _isAuthenticating = true;
    final success = await _authService.authenticate(
      reason: 'Authenticate to continue',
    );
    _isAuthenticating = false;

    if (success && context.mounted) {
      markActive(); // Reset the timer so it doesn't loop
      Navigator.of(context).pushNamedAndRemoveUntil('/invest', (_) => false);
    }
  }
}
