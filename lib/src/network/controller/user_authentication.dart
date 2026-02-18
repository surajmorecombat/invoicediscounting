import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserAuthentication extends ChangeNotifier {
  final storage = const FlutterSecureStorage();
  bool isLogin = false;

  Future<bool> checkLogin() async {
    final token = await storage.read(key: 'accessToken');
    isLogin = token != null;
    notifyListeners();
    return isLogin;
  }

  bool get loggedIn => isLogin;
}
