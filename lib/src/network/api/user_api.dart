import 'package:invoicediscounting/src/network/api/api.dart';

class UserApi extends Api {
  Future<dynamic> userLogin(jsonData) async {
    try {
      final response = await requestPost(
        path: '/auth/investor-login/send-otp',
        parameters: jsonData,
      );
      print('Login Response: $response');
      return response;
    } catch (e, _) {
      print(e);
      print('error');
    }
  }

  Future<dynamic> verifyOtp(jsonData) async {
    try {
      final response = await requestPost(
        path: '/auth/investor-login/verify-otp',
        parameters: jsonData,
      );
      print('Verify OTP Response: $response');
      return response;
    } catch (e, _) {
      print(e);
      print('error');
    }
  }

  Future<dynamic> sendPhoneOtp(jsonData) async {
    try {
      final response = await requestPost(
        path: '/auth/send-phone-otp',
        parameters: jsonData,
      );
      print('Send Phone OTP Response: $response');
      return response;
    } catch (e, _) {
      print(e);
      print('error');
    }
  }


   Future<dynamic> verifyPhoneOtp(jsonData) async {
    try {
      final response = await requestPost(
        path: '/auth/verify-phone-otp',
        parameters: jsonData,
      );
      print('Verify Phone OTP Response: $response');
      return response;
    } catch (e, _) {
      print(e);
      print('error');
    }
  }


   Future<dynamic> sendEmailOtp(jsonData) async {
    try {
      final response = await requestPost(
        path: '/auth/send-email-otp',
        parameters: jsonData,
      );
      print('Send Email OTP Response: $response');
      return response;
    } catch (e, _) {
      print(e);
      print('error');
    }
  }

    Future<dynamic> verifyEmailOtp(jsonData) async {
    try {
      final response = await requestPost(
        path: '/auth/verify-email-otp',
        parameters: jsonData,
      );
      print('Verify Email OTP Response: $response');
      return response;
    } catch (e, _) {
      print(e);
      print('error');
    }
  }
}
