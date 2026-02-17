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

  Future<dynamic> getKycProgess(jsonData) async {
    return await userApi.getKycProgess(jsonData);
  }

  Future<dynamic> fileUpload(String  filePath) async {
    return await userApi.fileUpload(filePath);
  }

  Future<dynamic> investorRegistration(jsonData) async {
    return await userApi.investorRegistration(jsonData);
  }

Future<dynamic> getIfsc(String ifscCode) async {
  return await userApi.getIfsc(ifscCode);
}


Future<dynamic> kycBankAdd(jsonData) async {
  return await userApi.kycBankAdd(jsonData);
}

}
