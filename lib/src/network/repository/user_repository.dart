import 'package:invoicediscounting/src/network/api/user_api.dart';

class UserRepository {
  final UserApi userApi = UserApi();

  Future<dynamic> userLogin(jsonData) async {
    return await userApi.userLogin(jsonData);
  }

  Future<dynamic> verifyOtp(jsonData) async {
    return await userApi.verifyOtp(jsonData);
  }

  Future<dynamic> sendPhoneOtp(jsonData) async {
    return await userApi.sendPhoneOtp(jsonData);
  }

  Future<dynamic> verifyPhoneOtp(jsonData) async {
    return await userApi.verifyPhoneOtp(jsonData);
  }

  Future<dynamic> sendEmailOtp(jsonData) async {
    return await userApi.sendEmailOtp(jsonData);
  }

  Future<dynamic> verifyEmailOtp(jsonData) async {
    return await userApi.verifyEmailOtp(jsonData);
  }
}
