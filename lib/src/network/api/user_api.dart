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
}
